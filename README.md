# Auto Netplan - GNU/Linux Automatic Net Config
- Programa por [Nisamov](https://github.com/Nisamov)
Programa configuración automatica Netplan
Este programa se centra en la automatización de configuración del programa netplan.

Auto Netplan es una herramienta diseñada para automatizar la configuración de redes en sistemas GNU/Linux utilizando Netplan. Simplifica el proceso de configuración y evita problemas comunes como errores de sintaxis o la introducción de configuraciones incorrectas.

Se recomienda seguir la [guía](https://github.com/Theritex/LinuxCommands/tree/main/system_data/network_configuration/netplan_net) creada por Nisamov previamente como apoyo durante la configuración manual.

El programa cuenta con un instalador, este instalara el programa dentro del sistema operativo, para ejecutarlo es necesario estar dentro de la ruta o especificar la ruta del fichero para su ejecución `bash (ruta)/install.sh`

## Estructura del Programa y Explicacion Visual
Estos ejemplos han sido creados para la completa comprension del programa.

### Estructura tras la instalacion
Esta es la estructura correspondiente tras la ejecucion del script `install.sh`, el cual clona y crea rutas dentro del sistema con el objetivo de repartir el programa de una forma completa dentro del mismo.
![Estructura del Programa tras Instalacion](public-media/post-structured.jpg)
### Estructura durante la creacion
Esta es la ruta de los ficheros del repositorio, con este esquema es posible trazar la ruta completa de cada fichero, asi como observar la creacion de nuevos, este esquema esta simplificado, para comprender la estructura completa del programa,s e recomienda ejecutar el siguiente comando:
```sh
# Abrir el fichero en texto plano para su compresion con permisos de super usuario
sudo nano ./install.sh
```
![Estructura del Programa durante Instalacion](public-media/full-structure-post-install.jpg)
Mediante la imagen mostrada previamente, es posible comprender el funcionamiento y clonacion de los ficheros del repositorio, tras la ejecucion del fichero `install.sh`, este cuenta con una seccion del fichero de isntalacion que borra el repositorio clonado, limpiando asi espacio ya no necesario en el sistema, siendo esta escript el siguiente:
```sh
# Tras la instalacion, el instalador, borrara el repositorio clonado para liberar espacio
# Verificar si la ruta $SCRIPT_DIR existe
if [[ -d "$SCRIPT_DIR" ]]; then
    # Si la ruta existe, eliminar de forma recursiva el directorio
    sudo rm -rf "$SCRIPT_DIR"
    # Mensaje de eliminación exitosa
    echo "[#] Se ha eliminado de forma recursiva el repositorio clonado."
else
    # Si la ruta no existe, mostrar un mensaje indicando que no existe
    echo "[#] La ruta '$SCRIPT_DIR' no existe."
fi
```


## Instalación
Para instalar Auto Netplan, sigue estos pasos:

Clona el repositorio:
```sh
sudo apt install git
git clone https://github.com/Nisamov/auto-netplan /ruta/de/instalacion
# Ejemplo de instalacion practica
# git clone https://github.com/Nisamov/auto-netplan /home/user/Github/cloned/
```

Navega hasta el directorio del repositorio clonado:
```sh
cd auto-netplan
# Ejemplo de acceso a la ruta de instalacion
# cd /home/user/Github/cloned/auto-netplan
```
Ejecuta el instalador:
```sh
sudo bash install.sh
```

## Operaciones
Las operaciones y posibilidades de ejecucion tras la instalacion son las siguientes:
```bash
# Para llamar al programa es necesario escribir el nombre del programa + parametros
autonetplan -x -a -iface -s -ip -ntmk
# llamada al programa + coninuacion con el programa + configuracion automatica + ip estatica + agregar interfaz + ingreso de ip fija + agregar mascara de red
```
Ejemplo esquemático en el uso y funcionamiento de autonetplan:
![Estructura del Programa tras Instalacion](public-media/function-structure.jpg)

Para comprender los parametros disponibles, se recomienda leer el siguiente cuadro:
```
    $1:_
        -h      / --help            >> Mostrar ayuda del programa
        -r      / --remove          >> Desinstalar el programa
        -l      / --license         >> Mostrar licencia del programa
        -b      / --backup          >> Crear copia seguridad configuracion actual red
        -x      / --execute         >> Continuar con la ejecucion del programa
        -m      / --manual
    $2:_
        -m      / --manual          >> Configuracion manual
        -a      / --automatic       >> Configuracion automatica
    $3:_
        -iface  / --interface       >> Indicar posteriormente la interfaz a usar
    $4:_
        -f      / --fluid           >> Configuracion DHCP (red fluida)
        -s      / --static          >> Configuracion fija (red estatica)
    $5:_
        -ip     / --ipconfigure     >> indicar posteriormente la ip fija
                                        (solo tras haber indicado previamente '-s')
    $6:_
        -ntmk   / --netmask         >> Establecer mascara de red posteriormente
```

# Configuracion
El programa autonetplan cuenta con un fichero de configuracion ubicado en la ruta:
`/usr/local/sbin/autonetplan/program-files/netplan-config/autonetplan.conf`
Este fichero cuenta con dos estados `true` o `false`, estos estados permiten activar o desactivar diferentes funciones del programa que puedan poner en peligro su uso.

Estos son algunos ejemplos del mismo:

`autonetplan-formatted-on-call=true`
Esta opcion permite poder llamar al programa multiples veces cambiando constantemente la red sin tener que editarla manualmente tras la primera configuracion aplicada, ahorrando tiempo innecesario para la configuracion manual.

`autonetplan-prevent-purge-on-mistake=true`
sta opcion permite deshabilitar la desinstalacion del programa mediante el comando `autonetplan -r`.