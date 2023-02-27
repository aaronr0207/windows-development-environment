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

# Elegir IDE y versión
$choice_ide = Read-Host "Instalar PHPStorm, VSCode o ambos (1,2 o 3)"

if ($choice_ide -eq "1") {
    $choice_version = Read-Host "Instalar última versión de PHPStorm o 2020.2.4 (versión licencia) (1 o 2)"
    
    if ($choice_version -eq "1") {
        choco install phpstorm
    } elseif ($choice_version -eq "2") {
        choco install phpstorm 2020.2.4
    } else {
        Write-Host "Opción no válida, elige 1 o 2"
    }
} elseif ($choice_ide -eq "2") {
   choco install vscode
} elseif ($choice_ide -eq "3") {
   choco install vscode
     $choice_version = Read-Host "Instalar última versión de PHPStorm o 2020.2.4 (versión licencia) (1 o 2)"
    if ($choice_version -eq "1") {
        choco install phpstorm
    } elseif ($choice_version -eq "2") {
        choco install phpstorm 2020.2.4
    } else {
        Write-Host "Opción no válida, elige 1 o 2"
    }
}else {
    Write-Host "Opción no válida, elige 1 (PHPStorm), 2 (VSCode) o 3 (ambos)"
}

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
choco install vlc -y

Update-Environment-Path

# Poner el tema oscuro
start "" "C:\Windows\Resources\Themes\themeB.theme"

# Cambiar wallpaper
cd ~
wget -O wallpaper.jpg https://github.com/aaronr0207/windows-development-environment/blob/main/wallpaper.jpg?raw=true
reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v Wallpaper /t REG_SZ /d "~\wallpaper.jpg" /f
RUNDLL32.EXE user32.dll,UpdatePerUserSystemParameters
rm ~\wallpaper.jpg

# Quitar los items anclados de la barra de tareas por defecto
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Taskband" /v Favorites /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Taskband" /v "FavoritesResolve" /t REG_DWORD /d 0 /f
powershell -Command 'Remove-Item -Path "$env:APPDATA\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar\*" -Force'

# Reiniciar el proceso del explorador para que tengan efecto los cambios
taskkill /f /im explorer.exe
start explorer.exe

# Windows Subsystem for Linux (de momento desactivado)
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


# Limpiar iconos del escritorio, menos la papelera de reciclaje

$desktop = [Environment]::GetFolderPath('Desktop')
$recycle_bin = [Shell32.Shell]::RecycleBin
$desktop_items = Get-ChildItem $desktop | Where-Object { $_.Extension -eq ".lnk" }

foreach ($item in $desktop_items) {
    $shortcut = (New-Object -ComObject WScript.Shell).CreateShortcut($item.FullName)
    if ($shortcut.TargetPath -ne $recycle_bin.Path) {
        Remove-Item $item.FullName
    }
}

Write-Output "Finalizado! Ejecuta `choco upgrade all` si necesitas actualizar el software (cuidado con la versión de phpstorm)"
