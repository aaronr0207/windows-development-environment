Para utilizar el sistema de archivos `nfs` para las carpetas compartidas de `homestead` tenemos que añadir dos reglas al firewall de windows, para ello:

* En la carpeta ~\.vagrant.d\gems\ copiamos la versión (por ejemplo: 2.7.6) y dentro de esta copiamos la versión que se instaló del `winnfsd` (por ejemplo: 1.4.0)
* Reemplazamos lo que hemos copiado en los siguientes comandos y los ejecutamos:

```
 netsh advfirewall firewall add rule name="VagrantWinNFSd-1.4.0" dir="in" action=allow protocol=any program=~\.vagrant.d\gems\2.7.6\gems\vagrant-winnfsd-1.4.0\bin\winnfsd.exe" profile=any
```


```
netsh advfirewall firewall add rule name="VagrantWinNFSd-1.4.0" dir="out" action=allow protocol=any program="~\.vagrant.d\gems\2.7.6\gems\vagrant-winnfsd-1.4.0\bin\winnfsd.exe" profile=any
```

Y por último recargamos `homestead` 

```
vagrant reload --provision
```

## IMPORTANTE:
Es posible que windows no reconozca `~` como el directorio personal (dependerá del terminal que usemos) por lo que debemos reemplazarlo con la ruta
de la carpeta personal del usuario que estemos utilizando, por ejemplo: `C:\Users\aaron` 
