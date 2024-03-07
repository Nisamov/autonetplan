#!/bin/bash
#Programa configuracion red Linux - Automatica

# Script de instalación de programa auto-netplan

# Ruta del directorio donde se encuentra el script de instalación
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# Ruta instalacion programa
INSTALL_DIR="/usr/local/bin"

# Copiar el script principal y el archivo de ayuda al directorio de instalación
cp "$SCRIPT_DIR/autonetplan/autonetplan.sh" "$INSTALL_DIR"
cp "$SCRIPT_DIR/autonetplan/help.md" "$INSTALL_DIR"

# Dar permisos de ejecución al script principal
chmod +x "$INSTALL_DIR/autonetplan.sh"

# Aviso instalacion completada
echo "El programa se ha instalado correctamente en $INSTALL_DIR"
# Mensaje automatico tras la isntalacion con la guia
echo "Puedes ejecutarlo con el comando: autonetplan.sh"

# En decicion (no implementado)
# Tras la isntalacion, el instalador, borrara el repositorio clonado para liberar espacio
# Funciones: Ubicar ruta actual, localizar ficheros de repositorio, borrar de forma recursiva el programa
# Tras esto enviaria un "Isntalacion y limpieza exitosa", para posteriormente esperar x segundos y borrarse a si mismo
# Al ser esto una version alfa, quedan ideas por implementar