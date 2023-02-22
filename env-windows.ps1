#-------------------------------------------------------------------------------#
#                                                                               #
# This script installs all the stuff I need to develop the things I develop.    #
# Run PowerShell with admin priveleges, type `env-windows`, and go make coffee. #
#                                                                               #
#                                                                        -James #
#                                                                               #
#-------------------------------------------------------------------------------#

#
# Functions
#

function Update-Environment-Path {
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")
}

function Push-User-Path($userPath) {
    $path = [Environment]::GetEnvironmentVariable('Path', 'User')
    $newpath = "$userPath;$path"
    [Environment]::SetEnvironmentVariable("Path", $newpath, 'User')
    Update-Environment-Path
}

#
# Package Managers
#

# Choco
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
Update-Environment-Path

# Utils
Get-Command -Module Microsoft.PowerShell.Archive

choco install adobereader -y
choco install googlechrome -y
choco install firefox -y
choco install vcredist140 --version 14.34.31938 -y
choco install google-drive-file-stream --version 56.0.11.2022 -y
choco install 7zip.install -y
choco install anydesk.install -y
choco install git -y
choco install vagrant -y
choco install virtualbox -y
choco install heidisql -y
choco install hyper -y
choco install logitech-options -y
choco install notepadplusplus.install -y
choco install phpstorm --version 2020.2.4 -y
choco install putty -y
choco install kitty -y
choco install sublimetext4 -y
choco install sublimemerge -y
choco install tableplus -y
choco install winscp -y
choco install pdf24 -y
choco install hostsman -y
choco install spotify -y
choco install postman -y
choco install androidstudio -y


Update-Environment-Path

# Poner el tema oscuro
start "" "C:\Windows\Resources\Themes\themeB.theme"

# Windows Subsystem for Linux
# wsl --install

# Homestead basic setup

cd ~
mkdir workspace
mkdir compartida
git clone https://github.com/laravel/homestead.git homestead
cd homestead
git checkout release
bash init.sh
vagrant plugin install vagrant-winnfsd

# Si se va a usar el sistema de archivos nfs hay que ejecutar los permisos (nota keep)
# La configuración del yaml hay que hacerla manualmente de momento

# Hacer homestead invocable desde cualquier ubicacion

cd ~
touch .bash_profile

echo function homestead() {> .bash_profile
echo     ( cd ~/Homestead && vagrant $* )>> .bash_profile
echo }>> .bash_profile


Write-Output "Finalizado! Ejecuta `choco upgrade all` si necesitas actualizar el software (cuidado con la versión de phpstorm)"
