#You need administrator priviledge to enable Legacy components (run PowerShell as admin)
Enable-WindowsOptionalFeature -Online -FeatureName "LegacyComponents" #Legacy components
Enable-WindowsOptionalFeature -Online -FeatureName "netfx3" #.NET Framewrok 3.5
#
#
#Change directory to home (~), make a new directory called DiscoveryFLtempDir and set it as working directory
cd ~ ; mkdir DiscoveryFLtempDir ; cd DiscoveryFLtempDir
#
#
#wget downloads .NET Framework 4.8 from official MS website
wget https://go.microsoft.com/fwlink/?LinkId=2085155 -OutFile DotNetFramework48.exe ; echo "
.NET Framework 4.8 finished downloading."
#
#
#wget downloads Freelancer ISO image
wget https://archive.org/download/Freelancer_201807/Freelancer.iso -OutFile Freelancer.iso ; echo "
Freelancer ISO image finished downloading."
#
#
#wget
wget https://discoverygc.com/files/discovery_4.91.0.1.exe -OutFile discovery_4.91.0.1.exe ; echo "
Discovery Freelancer installer finished downloading."
#Executes the installer (GUI will pop up, user has to manually go through installer as usual)
.\DotNetFramework48.exe | Out-Null
#
#
#Gets ISO full path and mounts the ISO
$disk=Mount-DiskImage -ImagePath (Get-Item .\Freelancer.iso).FullName
#
#
#Go to Freelancer directory and execute the installers
#(Freelancer and Direct X 9, although DX9 is probably not going to be needed)
cd ((($disk | Get-Volume).DriveLetter) + ":") ; .\SETUP.EXE  | Out-Null ; .\DIRECTX\DXSETUP.EXE
#
#
#And finally Discovery Freelancer installer:
cd ~\DiscoveryFLtempDir
.\discovery_4.91.0.1.exe | Out-Null