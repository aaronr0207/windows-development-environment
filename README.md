# Windows Development Environment

Script que prepara un entorno Windows con los programas necesarios para desarrollar con `Laravel` como lenguaje + `Homestead` como entorno virtual + `PhPStorm` como IDE  . Ejecuta `env-windows` en PowerShell y ve a por un café.

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
  * notepadplusplus
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
  * vlc
  * sqlitebrowser

* `Homestead_config_example.yaml` un archivo de configuración básico para `homestead` como ejemplo
* `hyper_config_basic` un archivo de configuración para `hyper` que pone `git-bash` como shell del terminal y un tema básico
* `hyper_fix_ls_colors_zsh.md` tutorial para arreglar el contraste de los colores de las carpetas al hacer ls cuando se utiliza `zsh` junto a `hyper` 
* `wallpaper.jpg` un wallpaper oscuro minimalista
* `vscode-extensions.sh` ejemplo de script para automatizar la configuración de VSCode (para futuras actualizaciones de este repo)
* Configuraciones adicionales:
  * Actualiza el `$PATH` tras instalar el software
  * Añade un `.bash_profile` con el alias para utilizar el comando `homestead` desde cualquier ruta en el terminal
  * Actualiza el tema de windows con el tema oscuro
  * Clona la última versión de `homestead` y lo inicializa
  * Instala el plugin `vagrant-winnfsd` para montar carpetas en `nfs`
  * Cambia el wallpaper por uno oscuro minimalista
  * Quita los iconos anclados por defecto en la barra de tareas
  * Quita `OneDrive` y lo deshabilita
  * Quita `Cortana` y lo deshabilita
  * Quita `Sugerencias de Windows`
* `vagrant-winnfsd.md` instrucciones para dar los permisos pertinentes para poder utilizar el sistema de archivos `nfs`

# Uso:

* Abre un powershell con privilegios de administrador y ubicate en la carpeta donde tengas el proyecto clonado
* Ejecuta el script:

```
.\env-windows.ps1
```

# TODO:
* Automatizar configuración de `VSCode` para `Laravel`
* Incluir más plugins para `hyper` 
* Quitar los programas anclados por defecto y anclar los que se usan
* Incluir software adicional o más herramientas de desarrollo
