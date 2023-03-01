Si utilizas ZSH en la consola de homestead, los colores al hacer un ``ls`` tienen poco contraste y se lee mal, para arreglarlo, vamos a editar
los archivos ``.bashrc`` y ``.zshrc`` y vamos a añadir al final de ambos, las siguientes lineas:

```
_ls_colors=":ow=01;33" 
zstyle ':completion:*:default' list-colors "${(s.:.)_ls_colors}"
LS_COLORS+=$_ls_colors
```
Una vez añadidas ejecutamos los siguientes comandos o reiniciamos la sesión del terminal

```
source ~/.bashrc
source ~/.zshrc
```
