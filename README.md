# Auto Netplan - GNU/Linux Automate Net Config
- Programa por [Nisamov](https://github.com/Nisamov)
Programa configuracion automatica Netplan
Este programa se centra en la automatización de configuración del programa netplan.

Se recomienda seguir la [guía](https://github.com/Theritex/LinuxCommands/tree/main/system_data/network_configuration/netplan_net) creada por Nisamov previamente como apoyo durante la configuración manual.

El programa cuenta con un instalador, este instalara el programa dentro del sistema operativo, para ejecutarlo es necesario estar dentro de la ruta o especificar la ruta del fichero para su ejecución `bash (ruta)/install.sh`
```sh
# Ruta del directorio donde se encuentra el script de instalación
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# Ruta instalacion programa
INSTALL_DIR="/usr/local/bin"

# Copiar el script principal y el archivo de ayuda al directorio de instalación
cp "$SCRIPT_DIR/programa/tu_script.sh" "$INSTALL_DIR"
cp "$SCRIPT_DIR/programa/help.md" "$INSTALL_DIR"

# Dar permisos de ejecución al script principal
chmod +x "$INSTALL_DIR/tu_script.sh"
```
<!--Boceto: Tras la isntalacion, se eliminara recursivamente los ficheros clonados, liberando espacio en el sistema-->