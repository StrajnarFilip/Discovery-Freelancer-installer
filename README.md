# Discovery-Freelancer-installer
Install script for Discovery Freelancer. This will only work on Windows 10.

In order to make this script work, you will have to execute it with Administrator privileges. You can do this easily by searching **PowerShell** in your start menu, and selecting **Run as Administrator**. In *(admin)* PowerShell, you want to type:

**Set-Executionpolicy Unrestricted -Scope Process -Force**

and hit Enter key. This will allow you to run this script (it's unsigned, since we're not a big corporation). You will also have to type **a** and Enter, to accept the changes. After this you can do it quickly by inserting the following command in your *(admin)* PowerShell:

**cd ~ ; Invoke-WebRequest https://raw.githubusercontent.com/StrajnarFilip/Discovery-Freelancer-installer/Version1.0.2/InstallScript.ps1 -OutFile installdiscoveryfreelancer.ps1 ; Unblock-File .\\installdiscoveryfreelancer.ps1 ; .\installdiscoveryfreelancer.ps1**

# Lazy method (copy paste only this one chain of commands) :
**cd ~ ; Set-Executionpolicy Unrestricted -Scope Process -Force ; Invoke-WebRequest https://raw.githubusercontent.com/StrajnarFilip/Discovery-Freelancer-installer/Version1.0.2/InstallScript.ps1 -OutFile installdiscoveryfreelancer.ps1 ; Unblock-File .\\installdiscoveryfreelancer.ps1 ; .\installdiscoveryfreelancer.ps1**
