<#
    Discovery Freelancer install script
    Copyright (C) 2020 Filip Strajnar, Switchback

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <https://www.gnu.org/licenses/>.
#>

#Function to test if user is an administrator (required for script to work)
#
#
$ProgressPreference = 'SilentlyContinue'
function Test-Administrator  
{  
    $user = [Security.Principal.WindowsIdentity]::GetCurrent();
    (New-Object Security.Principal.WindowsPrincipal $user).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)  
}
#
#
if(Test-Administrator)
{

#You need administrator priviledge to enable Legacy components (run PowerShell as admin)
Enable-WindowsOptionalFeature -Online -FeatureName "LegacyComponents" #Legacy components
echo "Legacy components have been enabled."
Enable-WindowsOptionalFeature -Online -FeatureName "netfx3" #.NET Framewrok 3.5
echo ".NET Framework 3.5 has been enabled."
#
#
#Change directory to home (~), make a new directory called DiscoveryFLtempDir and set it as working directory
cd ~ ; mkdir DiscoveryFLtempDir ; cd DiscoveryFLtempDir
#
#
#wget downloads .NET Framework 4.8 from official MS website
try{
wget https://go.microsoft.com/fwlink/?LinkId=2085155 -OutFile DotNetFramework48.exe ; echo "
.NET Framework 4.8 finished downloading."
}
catch
{
    echo "Download of .NET Framework 4.8 failed."
    exit
}
#
#
#wget downloads Freelancer ISO image
try{
wget https://archive.org/download/Freelancer_201807/Freelancer.iso -OutFile Freelancer.iso ; echo "
Freelancer ISO image finished downloading."
}
catch
{
    echo "Download of Freelancer ISO image failed."
    exit
}
#
#
#wget
try{
wget https://discoverygc.com/files/discovery_4.91.0.1.exe -OutFile discovery_4.91.0.1.exe ; echo "
Discovery Freelancer installer finished downloading."
}
catch
{
    echo "Download of Discovery Freelancer installer failed."
    exit
}
#Executes the installer (GUI will pop up, user has to manually go through installer as usual)
echo "Install .NET framework 4.8 with provided Graphical User Interface (GUI):"
.\DotNetFramework48.exe | Out-Null
#
#
#Gets ISO full path and mounts the ISO
$disk=Mount-DiskImage -ImagePath (Get-Item .\Freelancer.iso).FullName
#
#
#Go to Freelancer directory and execute the installers
#(Freelancer and Direct X 9, although DX9 is probably not going to be needed)
echo "Please install Freelancer in 'C:\Program Files (x86)\Microsoft Games\Freelancer' to make the installation easier for yourself."
cd ((($disk | Get-Volume).DriveLetter) + ":")
Start-Process .\SETUP.EXE -Wait
.\DIRECTX\DXSETUP.EXE
#
#
#And finally Discovery Freelancer installer:
cd ~\DiscoveryFLtempDir
echo "Install Discovery Freelancer Launcher with provided GUI:"
Start-Process .\discovery_4.91.0.1.exe -Wait
echo "You probably don't need the installer files anymore, delete them."
cd ~ ; rm DiscoveryFLtempDir

}
else
{
#Fails
echo "

  Reminder: You have to start PowerShell as an administrator for this script to work.

"
exit
}
