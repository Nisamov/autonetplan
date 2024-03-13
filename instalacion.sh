#!/bin/bash

# Programa por github.com/Nisamov
# Licencia Apache2.0

#Programa configuracion red Linux - Automatica
# Script de instalación de programa auto-netplan

# Ruta del directorio donde se encuentra el script de instalación
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# Ruta instalacion super usuario
INSTALL_DIR="/usr/local/sbin"

# Ruta ficheros programa super usuario
PROGRAM_FILES="/usr/local/sbin/auto-netplan/"

# Creacion directorio ficheros de programa
sudo mkdir $PROGRAM_FILES
# Mensaje tras la creacion de la ruta
echo -e "\e[32m[ \e[39m#\e[32m ] Se ha creado la ruta \e[39m$PROGRAM_FILES\e[32m exitosamente"

# Copiar el script principal al directorio de instalación renombrando el programa como autonetplan
sudo cp "$SCRIPT_DIR/autonetplan/autonetplan.sh" "$INSTALL_DIR/autonetplan"

# Mensaje tras la copia del fichero en la ruta de instalacion
echo -e "\e[32m[ \e[39m#\e[32m ] Se ha copiado exitosamente el programa en \e[39m$INSTALL_DIR"

# Dar permisos de ejecución al script principal
sudo chmod +x "$INSTALL_DIR/autonetplan"
# Mensaje tras otorgar correctamente los permisos
echo -e "\e[32m[ \e[39m#\e[32m ] Permisos necesarios otorgados correctamente"
# Copiar ficheros ejemplares en la ruta $PROGRAM_FILES
# Clonacion de contenido /program-files/xample/* dentro de ruta $PROGRAM_FILES de forma recursiva
sudo cp -r "$SCRIPT_DIR/program-files/" "$PROGRAM_FILES"
# Mensaje copia recursiva ficheros
echo -e "\e[32m[ \e[39m#\e[32m ] Se ha copiado exitosamente \e[39m$SCRIPT_DIR/program-files/ \e[32men \e[39m$PROGRAM_FILES"

# Aviso instalacion completada
echo -e "\e[32m[ \e[39m#\e[32m ] El programa se ha instalado correctamente en \e[39m$INSTALL_DIR"
# Mensaje automatico tras la isntalacion con la guia
echo -e "\e[32m[ \e[39m#\e[32m ] El programa ha sido instalado correctamente, para ejecutarlo usa 'autonetplan <parametros>'"

# Clonar el fichero de licencia dentro del resto de los ficheros
sudo cp -r "$SCRIPT_DIR/LICENSE.txt" "$PROGRAM_FILES"
# Mensaje clonacion licencia
echo -e "\e[32m[ \e[39m#\e[32m ] Licencia instalada correctamente 'autonetplan -l' para leerla."

# Funcion pausa
function pause(){
   read -p "$*"
}
#Espacio diferencial de texto
echo ""
# Llamada a funcion previa
pause 'Presione cualquier tecla para continuar...'

# Mensaje muestra de licencia
sudo less LICENSE.txt

# Tras la instalacion, el instalador, borrara el repositorio clonado para liberar espacio
# Funciones: Ubicar ruta actual, localizar ficheros de repositorio, borrar de forma recursiva el programa
sudo rm -rf $SCRIPT_DIR
# Mensaje aviso eliminacion repositorio
echo -e "\e[32m[ \e[39m#\e[32m ] Se ha eliminado de forma recursiva el repositorio clonado, las rutas del programa son: '\e[39m$INSTALL_DIR/autonetplan\e[32m' y '\e[39m$PROGRAM_FILES\e[32m'"
echo "[#] Para mostrar la lista de ayuda del programa autonetplan, ejecute el siguiente comando: 'autonetplan -h'"