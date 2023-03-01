# Plugins
* Artisan  (permite ejecutar artisan desde cualquier directorio de un proyecto y sin incluir php delante)
* TheFuck (arregla la sintaxis al fallar un comando y poner fuck)

# Instalación
### Artisan
```
git clone https://github.com/jessarcher/zsh-artisan.git ~/.oh-my-zsh/custom/plugins/artisan
```
Añade artisan al array de plugins 
```
plugins=(
    artisan
    git
)
```

### Fuck
Ejecuta los siguientes comandos
```
sudo apt update
sudo apt install python3-dev python3-pip python3-setuptools
pip3 install thefuck --user
```

## Despues de instalar 
```
source ~/.zshrc
```

O abre una nueva sesión del terminal