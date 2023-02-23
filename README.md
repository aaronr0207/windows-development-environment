# Windows Development Environment

Prepara un entorno Windows con los programas necesarios para desarrollar con `Laravel` como lenguaje + `Homestead` como entorno virtual y `PhPStorm` como IDE  . Ejecuta `env-windows` en PowerShell y ve a por un café.

# Contenido

* `env-windows.ps1` script principal que instala el siguiente software:
  * adobereader 
  * googlechrome 
  * firefox 
  * vcredist140 14.34.319
  * google-drive-file-stream 56.0.11.2022 
  * 7zip
  * anydesk 
  * git 
  * vagrant 
  * virtualbox 
  * heidisql 
  * hyper 
  * logitech-options 
  * notepadplusplus.install 
  * phpstorm 2020.2.4 
  * putty 
  * kitty 
  * sublimetext4 
  * sublimemerge 
  * tableplus 
  * winscp 
  * pdf24 
  * hostsman 
  * spotify 
  * postman 
  * androidstudio 

* `Homestead_config_example.yaml` un archivo de configuración básico para `homestead` como ejemplo
* `hyper_config_basic` un archivo de configuración para `hyper` que pone `git-bash` como shell del terminal y un tema básico
* `fix_ls_colors_zsh.md` tutorial para arreglar el contraste de los colores de las carpetas al hacer ls cuando se utiliza `zsh` junto a `hyper` 
* `wallpaper.jpg` un wallpaper oscuro minimalista
* `vscode-extensions.sh` ejemplo de script para automatizar la configuración de VSCode (para futuras actualizaciones de este repo)

# TODO:
* Instalar `VSCode`
* Automatizar configuración de `VSCode` para `Laravel`
* Permitir elegir en el shell si se instala `VSCode` o `PhPStorm`
