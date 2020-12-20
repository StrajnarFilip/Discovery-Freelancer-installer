#include <iostream>
#include <Windows.h>

int main()
{
    system("powershell -command \"Set-Executionpolicy Unrestricted -Scope Process -Force; Unblock-File .\\InstallScript.ps1 ; .\\InstallScript.ps1\"");
    printf("\n\nHave fun!");
    Sleep(10000);
}