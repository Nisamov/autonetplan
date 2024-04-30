#!/bin/bash

# Programa por github.com/Nisamov
#Copyright [2024] [Andres Abadias]
#
#Licensed under the Apache License, Version 2.0 (the "License");
#you may not use this file except in compliance with the License.
#You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
#Unless required by applicable law or agreed to in writing, software
#distributed under the License is distributed on an "AS IS" BASIS,
#WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#See the License for the specific language governing permissions and
#limitations under the License.

#Programa instalacion servicio autonetplan

# Ruta del directorio donde se encuentra el script de instalación
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
# Ruta instalacion super usuario
INSTALL_DIR="/usr/local/sbin"
# Ruta ficheros programa super usuario
PROGRAM_FILES="/usr/local/sbin/auto-netplan"
# Ruta netplan
NETWORK="/etc/netplan/"
# Ruta fichero de configuracion guardar dentro de /etc/autonetplan/autonetplan.conf
CONFIG_FILES="/etc"

# Limpiar consola para mejor lectura
clear

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

# Instalacion de ficheros de configuracion
while [[ ! -d $CONFIG_FILES/autonetplan ]]; do
    # Creacion de ruta
    sudo mkdir "$CONFIG_FILES/autonetplan"
    # Clonacion y renombramiento - copiar todo el contenido a la ruta de fichero de configuracion
    sudo cp -r $SCRIPT_DIR/auneconf/* "$CONFIG_FILES/autonetplan"

    if [[ -d "$CONFIG_FILES/autonetplan" ]]; then
        # Mensaje instalacion correcta
        echo "[#] Se ha creado la ruta $CONFIG_FILES/autonetplan exitosamente"
    else
        echo -e "[\e[31m#\e[0m] No se ha clonado $CONFIG_FILES correctamente, intentando de nuevo..."
        # Espera 1 segundo antes de intentar de nuevo
        sleep 1
    fi
done

# Verificar si el archivo principal existe en la ubicación correcta con el nombre correcto
if [[ -f "$INSTALL_DIR/autonetplan" ]]; then
    # Si el archivo existe, mostrar un mensaje indicando que ya está presente
    echo "[#] El script principal ya existe en $INSTALL_DIR/autonetplan"
else
    while [[ ! -f "$INSTALL_DIR/autonetplan" ]]; do
        echo -e "[\e[31m#\e[0m] El fichero autonetplan no existe, creando..."
        # Si el archivo no existe, intentar copiarlo y renombrarlo
        sudo cp "$SCRIPT_DIR/auto-netplan/autonetplan.sh" "$INSTALL_DIR/autonetplan"
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
fi

# Verificar si el programa de integridad de dir-file-search existe en la ruta indicada
if [[ -f "$INSTALL_DIR/auto-netplan/program-files/dir-file-search.sh" ]]; then
    # Si el archivo existe, mostrar un mensaje indicando que ya está presente
    echo "[#] El script de integridad ya existe en $INSTALL_DIR/auto-netplan/program-files/dir-file-search.sh"
else
    echo -e "[\e[31m#\e[0m] El fichero dir-file-search.sh no existe, creando..."
    # Si el archivo no existe, intentar copiarlo y renombrarlo
    sudo cp "$SCRIPT_DIR/auto-netplan/dir-file-search.sh" "$INSTALL_DIR/auto-netplan/program-files/dir-file-search.sh"
    if [[ -f "$INSTALL_DIR/autonetplan" ]]; then
        # Dar permisos de ejecución al script de integridad
        sudo chmod +x "$INSTALL_DIR/auto-netplan/program-files/dir-file-search.sh"
        # Mensaje tras otorgar correctamente los permisos
        echo "[#] Permisos necesarios otorgados al fichero de integridad correctamente"
    else
        # Mensaje si la copia no se realizó correctamente
        echo -e "[\e[31m#\e[0m] No se ha copiado el script de integridad correctamente, intentando de nuevo..."
        # Espera 1 segundo antes de intentar de nuevo
        sleep 1
    fi
fi

# Copiar ficheros ejemplares en la ruta $PROGRAM_FILES
# Clonacion de contenido /program-files/ dentro de ruta $PROGRAM_FILES de forma recursiva
sudo cp -r "$SCRIPT_DIR/program-files" "$PROGRAM_FILES"
# Verificar si la copia se realizó correctamente
if [[ -d "$PROGRAM_FILES/program-files/" ]]; then
    # Mensaje de copia exitosa
    echo "[#] Se ha copiado exitosamente $SCRIPT_DIR/program-files/* en $PROGRAM_FILES"
else
    # Mensaje si la copia no se realizó correctamente
    echo -e "[\e[31m#\e[0m] No se ha copiado el contenido de $SCRIPT_DIR/program-files/ correctamente, intentando de nuevo..."
    # Espera 1 segundo antes de intentar de nuevo
    sleep 1
fi

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
while [[ ! -d "$PROGRAM_FILES/autonetplan-backups" ]]; do
    # Clonar el archivo de licencia
    sudo mkdir "$PROGRAM_FILES/autonetplan-backups"
    # Verificacion de creacion
    if [[ -d "$PROGRAM_FILES/autonetplan-backups" ]]; then
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
# Tras la instalacion, el instalador, preguntara si borrar el repositorio clonado para liberar espacio
read -p "¿Desea borrar el repositorio clonado? [s/n]: " deleteRepos
if [[ $deleteRepos == "s" || $deleteRepos == "S" ]]; then
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
else
    echo "El repositorio no se eliminara del sistema"
fi

echo "[#] Las rutas del programa son: '$INSTALL_DIR/autonetplan' y '$PROGRAM_FILES'"
echo -e "[\e[32m#\e[0m] Programa instalado correctamente."
echo "[#] Mostrar la lista de ayuda del programa autonetplan, ejecute el comando: 'autonetplan -h'"