#!/bin/bash

# Programa por github.com/Nisamov
# Licencia Apache2.0

#Programa configuracion red Linux - Automatica
# Script de instalación de programa auto-netplan

# Ruta del directorio donde se encuentra el script de instalación
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# Ruta instalacion programa
INSTALL_DIR="/usr/local/bin"

# Creacion ruta ficheros programa
PROGRAM_FILES="/etc/auto-netplan/"

# Creacion directorio ficheros de programa
sudo mkdir $PROGRAM_FILES
# Mensaje tras la creacion de la ruta
echo "Se ha creado la ruta $PROGRAM_FILES exitosamente"

# Copiar el script principal al directorio de instalación
sudo cp "$SCRIPT_DIR/autonetplan/autonetplan.sh" "$INSTALL_DIR"
# Copiar configuracion a la ruta del programa
sudo cp "$SCRIPT_DIR/autonetplan/autonetplan.conf" "$INSTALL_DIR"

# Mensaje tras la copia del fichero en la ruta de instalacion
echo "Se ha copiado exitosamente el programa en $INSTALL_DIR"

# Dar permisos de ejecución al script principal
sudo chmod +x "$INSTALL_DIR/autonetplan.sh"
# Mensaje tras otorgar correctamente los permisos
echo "Permisos necesarios otorgados correctamente"
# Copiar ficheros ejemplares en la ruta $PROGRAM_FILES
# Clonacion de contenido /program-files/xample/* dentro de ruta $PROGRAM_FILES de forma recursiva
sudo cp "$SCRIPT_DIR/program-files/ -r" "$PROGRAM_FILES"

# Mensaje tras la creacion de sub-ruta
echo "Se ha creado la sub-ruta $PROGRAM_FILES/xample exitosamente"

# Aviso instalacion completada
echo "El programa se ha instalado correctamente en $INSTALL_DIR"
# Mensaje automatico tras la isntalacion con la guia
echo "El programa ha sido instalado correctamente, para ejecutarlo usa 'bash autonetplan.sh <parametros>'"

# Funcion pausa
function pause(){
   read -p "$*"
}

pause 'Presione cualquier tecla para continuar...'

# Mensaje muestra de licencia
echo "Licencia del programa | Apache2.0"
sudo less LICENSE.txt

# En decicion (no implementado)
# Tras la instalacion, el instalador, borrara el repositorio clonado para liberar espacio
# Funciones: Ubicar ruta actual, localizar ficheros de repositorio, borrar de forma recursiva el programa
# Tras esto enviaria un "Isntalacion y limpieza exitosa", para posteriormente esperar x segundos y borrarse a si mismo
# Al ser esto una version alfa, quedan ideas por implementar