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
Write-Host -ForegroundColor black -BackgroundColor white "Legacy components have been enabled."
Enable-WindowsOptionalFeature -Online -FeatureName "netfx3" #.NET Framewrok 3.5
Write-Host -ForegroundColor black -BackgroundColor white ".NET Framework 3.5 has been enabled."
#
#
#Change directory to home (~), make a new directory called DiscoveryFLtempDir and set it as working directory
cd ~
if( !(Test-Path .\DiscoveryFLtempDir)){
mkdir DiscoveryFLtempDir
}
cd DiscoveryFLtempDir
#
#
#Invoke-WebRequest downloads .NET Framework 4.8 from official MS website
try{
    if( !(Test-Path .\dotnet48test.txt)){
    if((Test-Path .\DotNetFramework48.exe)){
        Remove-Item .\DotNetFramework48.exe -Force
        Write-Host -ForegroundColor black -BackgroundColor white "Deleted wrong .NET Framework 4.8."
    }
    Invoke-WebRequest https://go.microsoft.com/fwlink/?LinkId=2085155 -OutFile DotNetFramework48.exe ; Write-Host -ForegroundColor black -BackgroundColor white "
    .NET Framework 4.8 finished downloading." ; New-Item -Path . -Name "dotnet48test.txt"
    }
    else
    {
        Write-Host -ForegroundColor black -BackgroundColor white ".NET Framework 4.8 already downloaded."
    }
}
catch
{
    Write-Host -ForegroundColor yellow -BackgroundColor black "Download of .NET Framework 4.8 failed."
    exit
}
#
#
#Invoke-WebRequest downloads Freelancer ISO image
try{
    if( !(Test-Path .\freelancerisotest.txt)){
    if((Test-Path .\Freelancer.iso)){
        Remove-Item .\Freelancer.iso -Force
        Write-Host -ForegroundColor black -BackgroundColor white "Deleted wrong Freelancer ISO."
    }
    Invoke-WebRequest https://archive.org/download/Freelancer_201807/Freelancer.iso -OutFile Freelancer.iso ; Write-Host -ForegroundColor black -BackgroundColor white "
    Freelancer ISO image finished downloading." ; New-Item -Path . -Name "freelancerisotest.txt"
    }
    else
    {
        Write-Host -ForegroundColor black -BackgroundColor white "Freelancer ISO already downloaded."
    }
}
catch
{
    Write-Host -ForegroundColor yellow -BackgroundColor black "Download of Freelancer ISO image failed."
    exit
}
#
#
#wget
try{
    if( !(Test-Path .\discoveryinstallertest.txt)){   
    if((Test-Path .\discovery_4.91.0.1.exe)){
        Remove-Item .\discovery_4.91.0.1.exe -Force
        Write-Host -ForegroundColor black -BackgroundColor white "Deleted wrong Discovery installer."
    }         
    Invoke-WebRequest https://discoverygc.com/files/discovery_4.91.0.1.exe -OutFile discovery_4.91.0.1.exe ; Write-Host -ForegroundColor black -BackgroundColor white "
    Discovery Freelancer installer finished downloading." ; New-Item -Path . -Name "discoveryinstallertest.txt"
    }
        else
    {
        Write-Host -ForegroundColor black -BackgroundColor white "Discovery Freelancer installer already downloaded."
    }
}
catch
{
    Write-Host -ForegroundColor yellow -BackgroundColor black "Download of Discovery Freelancer installer failed."
    exit
}
#Executes the installer (GUI will pop up, user has to manually go through installer as usual)
Write-Host -ForegroundColor black -BackgroundColor white "Install .NET framework 4.8 with provided Graphical User Interface (GUI):"
.\DotNetFramework48.exe | Out-Null
#
#
#Gets ISO full path and mounts the ISO
$disk=Mount-DiskImage -ImagePath (Get-Item .\Freelancer.iso).FullName
#
#
#Go to Freelancer directory and execute the installers
#(Freelancer and Direct X 9, although DX9 is probably not going to be needed)
Write-Host -ForegroundColor black -BackgroundColor green "Note: remember where you install the base Freelancer game as you will need to know to install Discovery"
cd ((($disk | Get-Volume).DriveLetter) + ":")
Start-Process .\SETUP.EXE -Wait
Start-Process .\DIRECTX\DXSETUP.EXE -Wait
#
#
#And finally Discovery Freelancer installer:
cd ~\DiscoveryFLtempDir
Write-Host -ForegroundColor black -BackgroundColor white "Install Discovery Freelancer Launcher with provided GUI:"
Start-Process .\discovery_4.91.0.1.exe -Wait
$choice = Read-Host "If Discovery Freelancer installed successfully, you may choose to delete temporary files. Type yes, to delete them."
if($choice -eq "yes")
{
    Write-Host "Deleting the temporary files." 
    Dismount-DiskImage ($disk).ImagePath
    cd ~
    Remove-Item -Path .\DiscoveryFLtempDir -Recurse -Force
}
}
else
{
#Fails
Write-Host -ForegroundColor yellow -BackgroundColor black "

  Reminder: You have to start PowerShell as an administrator for this script to work.

"
exit
}