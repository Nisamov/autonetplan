#!/bin/bash

# Programa por github.com/Nisamov
# Licencia Apache2.0

#Programa instalacion servicio autonetplan

# Ruta del directorio donde se encuentra el script de instalación
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# Ruta instalacion super usuario
INSTALL_DIR="/usr/local/sbin"

# Ruta ficheros programa super usuario
PROGRAM_FILES="/usr/local/sbin/auto-netplan/"

# Ruta netplan
NETWORK="/etc/netplan/"

# Creacion e instalacion rutas y ficheros del programa
while [[ ! -d $PROGRAM_FILES ]]; do
   # Creacion directorio $PROGRAM_FILES
    sudo mkdir -p $PROGRAM_FILES
    # Si el directorio existe
    if [[ -d $PROGRAM_FILES ]]; then
         # Mensaje instalacion correcta
        echo "[#] Se ha creado la ruta $PROGRAM_FILES exitosamente"
   # Si el directorio no existe
    else
        echo -e "[\e[31m#\e[0m] No se ha clonado $PROGRAM_FILES correctamente, intentando de nuevo..."
        # Espera 1 segundo antes de intentar de nuevo
        sleep 1
    fi
done


# Problemas copia de script - revisar
# Copiar el script principal al directorio de instalación renombrando el programa como autonetplan
while [[ ! -f "$INSTALL_DIR/autonetplan" ]]; do
    # Copiar el archivo
    sudo cp "$SCRIPT_DIR/autonetplan/autonetplan.sh" "$INSTALL_DIR/autonetplan"
    # Verificar si la copia se realizó correctamente
    if [[ -f "$INSTALL_DIR/autonetplan" ]]; then
        # Mensaje de copia exitosa
        echo "[#] El script principal se ha copiado exitosamente a $INSTALL_DIR/autonetplan"
        # Dar permisos de ejecución al script principal
        sudo chmod +x "$INSTALL_DIR/autonetplan"
        # Mensaje tras otorgar correctamente los permisos
        echo "[#] Permisos necesarios otorgados correctamente"
    else
        # Mensaje si la copia no se realizó correctamente
        echo -e "[\e[31m#\e[0m] No se ha copiado el script principal correctamente, intentando de nuevo..."
        # Espera 1 segundo antes de intentar de nuevo
        sleep 1
    fi
done

# Copiar ficheros ejemplares en la ruta $PROGRAM_FILES
while [[ ! -d "$PROGRAM_FILES" ]]; do
    # Clonacion de contenido /program-files/ dentro de ruta $PROGRAM_FILES de forma recursiva
    sudo cp -r "$SCRIPT_DIR/program-files/" "$PROGRAM_FILES"
    # Verificar si la copia se realizó correctamente
    if [[ -d "$PROGRAM_FILES" ]]; then
        # Mensaje de copia exitosa
        echo "[#] Se ha copiado exitosamente $SCRIPT_DIR/program-files/ en $PROGRAM_FILES"
    else
        # Mensaje si la copia no se realizó correctamente
        echo -e "[\e[31m#\e[0m] No se ha copiado el contenido de $SCRIPT_DIR/program-files/ correctamente, intentando de nuevo..."
        # Espera 1 segundo antes de intentar de nuevo
        sleep 1
    fi
done

# Clonar el fichero de licencia dentro del resto de los ficheros
while [[ ! -f "$PROGRAM_FILES/LICENSE.txt" ]]; do
    # Clonar el archivo de licencia
    sudo cp "$SCRIPT_DIR/LICENSE.txt" "$PROGRAM_FILES"
    # Verificar si la clonación se realizó correctamente
    if [[ -f "$PROGRAM_FILES/LICENSE.txt" ]]; then
        # Mensaje de clonación exitosa de la licencia
        echo "[#] Licencia instalada correctamente 'autonetplan -l' para leerla."
    else
        # Mensaje si la clonación no se realizó correctamente
        echo -e "[\e[31m#\e[0m] No se ha clonado la licencia correctamente, intentando de nuevo..."
        # Espera 1 segundo antes de intentar de nuevo
        sleep 1
    fi
done

# Crear ruta copias de seguridad
while [[ ! -d "$PROGRAM_FILES/netplan-backups" ]]; do
    # Clonar el archivo de licencia
    sudo mkdir "$PROGRAM_FILES/netplan-backups"
    # Verificacion de creacion
    if [[ -d "$PROGRAM_FILES/netplan-backups" ]]; then
        # Mensaje creacion almacenamiento copias de seguridad
        echo "[#] Ruta clonacion copias de seguridad, creada exitosamente"
    else
        # Mensaje si la creacion no se realizó correctamente
        echo -e "[\e[31m#\e[0m] Ha ocurrido un error en la creacion, intentando de nuevo..."
        # Espera 1 segundo antes de intentar de nuevo
        sleep 1
    fi
done

# Otorgar permisos a fichero de configuracion y contenido en su interior
sudo chmod 777 $NETWORK/*

# Creación de ficheros ocultos
while [[ ! -f "$PROGRAM_FILES/.106" ]]; do
    # Clonar el fichero oculto .106
    sudo touch "$PROGRAM_FILES/.106"
    # No serán verificados
done
# Contenido
# Contenido en proceso de edicion

# Funcion pausa
function pause(){
   read -p "$*"
}
#Espacio diferencial de texto
echo ""
# Llamada a funcion previa
pause 'Presione cualquier tecla para continuar...'
# Limpiar consola
clear
# Mensaje muestra de licencia
sudo less LICENSE.txt
# Limpiar consola
clear
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

echo "Las rutas del programa son: '$INSTALL_DIR/autonetplan' y '$PROGRAM_FILES'"
echo -e "[\e[32m#\e[0m] Programa instalado correctamente."
echo "[#] Mostrar la lista de ayuda del programa autonetplan, ejecute el comando: 'autonetplan -h'"
sleep 3

# Limpiar consola
read -p "¿Desea limpiar la consola? (s/n): " clrcnsl
if [[ $clrcnsl != "s" || $clrcnsl != "S" ]]; then
    # Limpia consola
    clear
fi