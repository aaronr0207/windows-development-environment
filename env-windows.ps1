#
# Vars
#
$phpIniPath = "C:\tools\php82\php.ini"
$fileInfoExtension = "php_fileinfo.dll"
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
# Comprobar permisos de administrador
#
If (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Warning "Debes ejecutar el script como administrador"
    Exit
}


#
# Quitar OneDrive
#

# Remove OneDrive from the computer
Get-AppxPackage *OneDrive* | Remove-AppxPackage

# Disable OneDrive from running on startup
Set-ItemProperty -Path "HKLM:\Software\Policies\Microsoft\Windows\OneDrive" -Name "DisableFileSyncNGSC" -Value 1

# Disable OneDrive from running in the background
Set-ItemProperty -Path "HKLM:\Software\Policies\Microsoft\Windows\OneDrive" -Name "DisableFileSync" -Value 1

# Remove OneDrive folder from the user's profile
$OneDrivePath = "$env:USERPROFILE\OneDrive"
If (Test-Path $OneDrivePath) {
    Remove-Item $OneDrivePath -Recurse
}

Write-Output "OneDrive eliminado y desactivado."

#
# Quitar Cortana
#

# Disable Cortana
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Personalization\Settings" -Name "AcceptedPrivacyPolicy" -Type DWord -Value 0
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\InputPersonalization" -Name "RestrictImplicitTextCollection" -Type DWord -Value 1
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\InputPersonalization" -Name "RestrictImplicitInkCollection" -Type DWord -Value 1
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\InputPersonalization\TrainedDataStore" -Name "HarvestContacts" -Type DWord -Value 0
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search" -Name "AllowCortana" -Type DWord -Value 0

# Stop Cortana processes
Stop-Process -Name "SearchUI"

# Uninstall Cortana
Get-AppxPackage Microsoft.549981C3F5F10 | Remove-AppxPackage

Write-Output "Cortana eliminado y desactivado."

#
# Quitar Sugerencias de Windows
#
# Disable "Get even more out of Windows" suggestion
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "ContentDeliveryAllowed" -Type DWord -Value 0
	Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "OemPreInstalledAppsEnabled" -Type DWord -Value 0
	Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "PreInstalledAppsEnabled" -Type DWord -Value 0
	Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "PreInstalledAppsEverEnabled" -Type DWord -Value 0
	Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SilentInstalledAppsEnabled" -Type DWord -Value 0
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-338387Enabled" -Type DWord -Value 0
	Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-338388Enabled" -Type DWord -Value 0
	Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-338389Enabled" -Type DWord -Value 0
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-338393Enabled" -Type DWord -Value 0
	Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-353698Enabled" -Type DWord -Value 0
	Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SystemPaneSuggestionsEnabled" -Type DWord -Value 0
	Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent" -Name "DisableWindowsConsumerFeatures" -Type DWord -Value 1
Write-Output "Sugerencias de Windows eliminadas."
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
    $choice_version = Read-Host "Instalar ultima version de PHPStorm o 2020.2.4 (version licencia) (1 o 2)"
    
    if ($choice_version -eq "1") {
        choco install phpstorm -y
    } elseif ($choice_version -eq "2") {
        choco install phpstorm 2020.2.4 -y
    } else {
        Write-Host "Opcion no valida, elige 1 o 2"
    }
} elseif ($choice_ide -eq "2") {
   choco install vscode -y
} elseif ($choice_ide -eq "3") {
   choco install vscode -y
     $choice_version = Read-Host "Instalar ultima version de PHPStorm o 2020.2.4 (version licencia) (1 o 2)"
    if ($choice_version -eq "1") {
        choco install phpstorm -y
    } elseif ($choice_version -eq "2") {
        choco install phpstorm 2020.2.4 -y
    } else {
        Write-Host "Opcion no valida, elige 1 o 2"
    }
}else {
    Write-Host "Opcion no valida, elige 1 (PHPStorm), 2 (VSCode) o 3 (ambos)"
}

$citrix = Read-Host "¿Instalar Citrix XenServer?, elige 1 (si) o 2 (no)"
if ($citrix -eq "1") {
choco install xencenter
} else {
Write-Host "Opcion no valida, elige 1 o 2"
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
choco install sqlitebrowser -y
choco install composer -y
choco install nodejs -y
choco install keepass -y

Update-Environment-Path


# Check if the php.ini file exists
if (Test-Path $phpIniPath) {
    # Check if the extension is already enabled
    $extensionEnabled = Get-Content $phpIniPath | Select-String -Pattern "^;?\s*extension\s*=\s*$extensionName"
    if (!$extensionEnabled) {
        # Enable the extension
        (Get-Content $phpIniPath) | Foreach-Object {
            if ($_ -match "^;?\s*;?\s*extension\s*=") {
                $_ -replace "^;?\s*;?\s*extension\s*=", "extension="
            } else {
                $_
            }
        } | Set-Content $phpIniPath
        Write-Host "La extension $fileInfoExtension ha sido activada en $phpIniPath"
    } else {
        Write-Host "La extension $fileInfoExtension ya esta activada en $phpIniPath"
    }
} else {
    Write-Host "No existe el archivo $phpIniPath "
}

# Poner el tema oscuro
start "C:\Windows\Resources\Themes\themeB.theme"

# Cambiar wallpaper
cd ~
wget -O wallpaper.jpg https://github.com/aaronr0207/windows-development-environment/blob/main/wallpaper.jpg?raw=true
reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v Wallpaper /t REG_SZ /d "~\wallpaper.jpg" /f
RUNDLL32.EXE user32.dll,UpdatePerUserSystemParameters
rm ~\wallpaper.jpg

# Quitar los items anclados de la barra de tareas por defecto
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Taskband" /v Favorites /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Taskband" /v "FavoritesResolve" /t REG_DWORD /d 0 /f
# Remove Search, Chat, and Desktops icons from taskbar
$taskbarLayout = (Get-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Taskband' -Name 'Favorites')

# Remove Search icon
$taskbarLayout.Favorites = $taskbarLayout.Favorites -replace 'System\.Search\.HomeTile', ''

# Remove Chat icon
$taskbarLayout.Favorites = $taskbarLayout.Favorites -replace 'Microsoft\.Teams\.Chat', ''

# Remove Desktops icon
$taskbarLayout.Favorites = $taskbarLayout.Favorites -replace 'Microsoft\.Windows\.Desktops\.App', ''
Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Taskband' -Name 'Favorites' -Value $taskbarLayout.Favorites

# Reiniciar el proceso del explorador para que tengan efecto los cambios
taskkill /f /im explorer.exe
start explorer.exe

# Windows Subsystem for Linux (de momento desactivado)
# wsl --install

# Homestead basic setup

cd ~
git clone https://github.com/laravel/homestead.git homestead
cd homestead
git checkout release
.\init.bat
vagrant plugin install vagrant-winnfsd

# Si se va a usar el sistema de archivos nfs hay que ejecutar los permisos (nota keep)
# La configuración del yaml hay que hacerla manualmente de momento

# Hacer homestead invocable desde cualquier ubicacion

cd ~
touch .bash_profile

$content = 'function homestead() {
    ( cd ~/Homestead && vagrant $* )
}'

Set-Content -Path "$env:USERPROFILE\.bash_profile" -Value $content -Encoding UTF8


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

# Listado de aplicaciones que se van a anclar en la barra de tareas
$executableNames = @("phpstorm64.exe", "sublime_text.exe", "explorer.exe","chrome.exe","Hyper.exe")

# Loopea sobre el array anterior para buscarlas
foreach ($executableName in $executableNames) {
    # Localizar los ejecutables con Get-Command cmdlet
    $executable = Get-Command $executableName -ErrorAction SilentlyContinue

    # Si lo encuentra, lo pinea
    if ($executable) {
        # Pinear usando Shell.Application COM object
        $shell = New-Object -ComObject Shell.Application
        $item = $shell.Namespace((Get-Item $executable.Source).DirectoryName).ParseName((Get-Item $executable.Source).Name)
        $verb = $item.Verbs() | where { $_.Name -eq 'Pin to Tas&kbar' }
        if ($verb) {
            $verb.DoIt()
        }
    }
}

# Crear carpetas para workspace
cd ~
mkdir workspace
mkdir compartida
mkdir workspace-android

Write-Output "Finalizado! Ejecuta `choco upgrade all` si necesitas actualizar el software (cuidado con la version de phpstorm)"
