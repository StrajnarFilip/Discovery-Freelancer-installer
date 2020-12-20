/*  Discovery Freelancer installer
    Copyright (C) 2020  Filip Strajnar

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
    */

#include <iostream>
#include <Windows.h>

int main()
{
    system("powershell -command \"Set-Executionpolicy Unrestricted -Scope Process -Force; Unblock-File .\\InstallScript.ps1 ; .\\InstallScript.ps1\"");
    printf("\n\nHave fun!");
    Sleep(10000);
}
