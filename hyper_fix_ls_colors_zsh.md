Si utilizas ZSH en la consola de homestead, los colores al hacer un ``ls`` tienen poco contraste y se lee mal, para arreglarlo, vamos a editar
los archivos ``.bashrc`` y ``.zshrc`` y vamos a añadir al final de ambos, las siguientes lineas:

```
LS_COLORS='ow=01;36;40'
export LS_COLORS
```
Una vez añadidas ejecutamos los siguientes comandos

```
source ~/.bashrc
source ~/.zshrc
```
