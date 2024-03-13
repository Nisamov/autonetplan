# Auto Netplan - GNU/Linux Automatic Net Config
- Programa por [Nisamov](https://github.com/Nisamov)
Programa configuracion automatica Netplan
Este programa se centra en la automatización de configuración del programa netplan.

Auto Netplan es una herramienta diseñada para automatizar la configuración de redes en sistemas GNU/Linux utilizando Netplan. Simplifica el proceso de configuración y evita problemas comunes como errores de sintaxis o la introducción de configuraciones incorrectas.

Se recomienda seguir la [guía](https://github.com/Theritex/LinuxCommands/tree/main/system_data/network_configuration/netplan_net) creada por Nisamov previamente como apoyo durante la configuración manual.

El programa cuenta con un instalador, este instalara el programa dentro del sistema operativo, para ejecutarlo es necesario estar dentro de la ruta o especificar la ruta del fichero para su ejecución `bash (ruta)/install.sh`

Instalación
Para instalar Auto Netplan, sigue estos pasos:

Clona el repositorio:
```sh
sudo apt install git
git clone https://github.com/Nisamov/auto-netplan.git
```

Navega hasta el directorio del repositorio clonado:
```sh
cd auto-netplan
```
Ejecuta el instalador:
```sh
sudo bash install.sh
```

El instalador copiará los archivos necesarios y configurará los permisos adecuados para que el programa funcione correctamente.

Uso
Una vez instalado, puedes llamar al programa autonetplan.sh con los siguientes parámetros:
```
-h / --help: Muestra la ayuda del programa.
-r / --remove: Desinstala el programa.
-x / --execute: Continúa con la ejecución del programa.
Además, puedes especificar el modo de configuración (-m para manual, -a para automático), el tipo de configuración (-f para DHCP, -s para estática), la interfaz de red, la dirección IP, la máscara de red y la puerta de enlace.
```

El programa devuelve los siguientes códigos de salida:

`0`: Éxito.

`1`: Error en la introducción de valores.
Notas
Se recomienda seguir la guía de configuración creada por Nisamov como apoyo durante la configuración manual.

Después de la instalación, los archivos clonados se eliminarán recursivamente, liberando espacio en el sistema. de instalación:
```sh
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
```

## Ruta instalacion programa
```sh
# Ruta instalacion super usuario
INSTALL_DIR="/usr/local/sbin"
# Ruta ficheros programa super usuario
PROGRAM_FILES="/usr/local/sbin/auto-netplan/"
```

```bash
# Tras la instalacion, el instalador, borrara el repositorio clonado para liberar espacio
# Funciones: Ubicar ruta actual, localizar ficheros de repositorio, borrar de forma recursiva el programa
sudo rm -rf $SCRIPT_DIR
```

Tras ser ejecutado el script de instalacion, el repositorio es eliminado para liberar almacenamiento.