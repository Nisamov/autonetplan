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
# Programa listo para funcionamiento, posteriormente, correccion y agregacion de mejoras

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

# Preguntar sobre el idioma a usar, segun eso, los ficheros se redistribuiran unicamente en el idioma establecido
# Unicamente van a estar disponibles dos idiomas, el ingles y el español (idioma origen)
# Los comentarios no van a ser traducidos, unicamente los mensajes de salida, ahorrando tiempo en la ejecucion de codigo y liberando peso innecesario (para algo estan los traductores)
while true; do
    # No se continuara hasta que se seleccione un lenguaje
    read -p "[AutoNetplan]: Select your language / Seleccione su idioma [eng/esp]: " language

    if [[ $language == "esp" ]]; then
        echo "[#] Se ha seleccionado el idioma Español"
        break
    elif [[ $language == "eng" ]]; then
        echo "[#] You've selected English language"
        break
    else
        echo "[#] Invalid language / Idioma inválido"
    fi
done

# Creacion e instalacion rutas y ficheros del programa
while [[ ! -d $PROGRAM_FILES ]]; do
   # Creacion directorio $PROGRAM_FILES
    sudo mkdir -p $PROGRAM_FILES
    # Si el directorio existe
    if [[ -d $PROGRAM_FILES ]]; then
         # Mensaje instalacion correcta
        if [[ $language == "esp" ]]; then
            echo "[#] Se ha creado la ruta $PROGRAM_FILES exitosamente"
        else
            echo "[#] Path $PROGRAM_FILES has been created successfully".
        fi
   # Si el directorio no existe
    else
        if [[ $language == "esp" ]]; then
            echo -e "[\e[31m#\e[0m] No se ha clonado $PROGRAM_FILES correctamente, intentando de nuevo..."
            # Espera 1 segundo antes de intentar de nuevo
            sleep 1
        else
            echo -e "[\e[31m#\e[0m] Failed to clone $PROGRAM_FILES successfully, trying again..."
            sleep 1
        fi
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
        if [[ $language == "esp" ]]; then
            echo "[#] Se ha creado la ruta $CONFIG_FILES/autonetplan exitosamente"
        else
            echo "[#] Path $CONFIG_FILES/autonetplan has been created successfully".
        fi
    else
        if [[ $language == "esp" ]]; then
            echo -e "[\e[31m#\e[0m] No se ha clonado $CONFIG_FILES correctamente, intentando de nuevo..."
            # Espera 1 segundo antes de intentar de nuevo
            sleep 1
        else
            echo -e "[31m] Failed to clone $CONFIG_FILES successfully, trying again..."
            sleep 1
        fi
    fi
done

# Verificar si el archivo principal existe en la ubicación correcta con el nombre correcto
if [[ -f "$INSTALL_DIR/autonetplan" ]]; then
    if [[ $language == "esp" ]]; then
        # Si el archivo existe, mostrar un mensaje indicando que ya está presente
        echo "[#] El script principal ya existe en $INSTALL_DIR/autonetplan"
    else
        echo "[#] The main script already exists in $INSTALL_DIR/autonetplan".
    fi
else
    while [[ ! -f "$INSTALL_DIR/autonetplan" ]]; do
        if [[ $language == "esp" ]]; then
            echo -e "[\e[31m#\e[0m] El fichero autonetplan no existe, creando..."
        else
            echo -e "[\e[31m#\e[0m] The autonetplan file does not exist, creating..."
        fi
        # Si el archivo no existe, intentar copiarlo y renombrarlo
        sudo cp "$SCRIPT_DIR/auto-netplan/autonetplan.sh" "$INSTALL_DIR/autonetplan"
        # Verificar si la copia se realizó correctamente
        if [[ -f "$INSTALL_DIR/autonetplan" ]]; then
            # Mensaje de copia exitosa
            if [[ $language == "esp" ]]; then
                echo "[#] El script principal se ha copiado exitosamente a $INSTALL_DIR/autonetplan"
            else
                echo "[#] The main script has been successfully copied to $INSTALL_DIR/autonetplan."
            fi
            # Dar permisos de ejecución al script principal
            sudo chmod +x "$INSTALL_DIR/autonetplan"
            # Mensaje tras otorgar correctamente los permisos
            if [[ $language == "esp" ]]; then
                echo "[#] Permisos necesarios otorgados correctamente"
            else
                echo "[#] Necessary permissions successfully granted".
            fi
        else
            # Mensaje si la copia no se realizó correctamente
            if [[ $language == "esp" ]]; then
                echo -e "[\e[31m#\e[0m] No se ha copiado el script principal correctamente, intentando de nuevo..."
                # Espera 1 segundo antes de intentar de nuevo
                sleep 1
            else
                echo -e "[31m] Failed to copy main script successfully, try again..."
                sleep 1
            fi
        fi
    done
fi

# Copiar ficheros ejemplares en la ruta $PROGRAM_FILES
# Clonacion de contenido /program-files/ dentro de ruta $PROGRAM_FILES de forma recursiva
sudo cp -r "$SCRIPT_DIR/program-files" "$PROGRAM_FILES"
# Verificar si la copia se realizó correctamente
if [[ -d "$PROGRAM_FILES/program-files/" ]]; then
    # Mensaje de copia exitosa
    if [[ $language == "esp" ]]; then
        echo "[#] Se ha copiado exitosamente $SCRIPT_DIR/program-files/* en $PROGRAM_FILES"
    else
        echo "[#] $SCRIPT_DIR/program-files/* has been successfully copied into $PROGRAM_FILES"
    fi
else
    # Mensaje si la copia no se realizó correctamente
    if [[ $language == "esp" ]]; then
        echo -e "[\e[31m#\e[0m] No se ha copiado el contenido de $SCRIPT_DIR/program-files/ correctamente, intentando de nuevo..."
        # Espera 1 segundo antes de intentar de nuevo
        sleep 1
    else
        echo -e "[31m] Failed to copy the contents of $SCRIPT_DIR/program-files/ successfully, trying again..."
        sleep 1
    fi
fi

# Agregar informacion del idioma en el fichero $PROGRAM_FILES/program-files/laguage.lg
# Independientemente del idioma elegido y registrado, se seguira llevando a cabo el proceso anterior para el output de lenguaje
# Revisar existencia de fichero de idioma
if [[ -f "/$PROGRAM_FILES/program-files/laguage.lg" ]]; then
    # Segun el idioma escogido
    if [[ "$laguage" == "esp" ]]; then
        echo "[#] Fichero /$PROGRAM_FILES/program-files/laguage.lg existente."
        echo "[#] Registrando idioma en el fichero..."
        # Codigo de registro
    else
        echo "[#] Existing /$PROGRAM_FILES/program-files/language.lg file."
        echo "[#] Registering language in the file..."
        # Codigo de registro
    fi
fi

# Clonar el fichero de licencia dentro del resto de los ficheros
while [[ ! -f "$PROGRAM_FILES/LICENSE.txt" ]]; do
    # Clonar el archivo de licencia
    sudo cp "$SCRIPT_DIR/LICENSE.txt" "$PROGRAM_FILES"
    # Verificar si la clonación se realizó correctamente
    if [[ -f "$PROGRAM_FILES/LICENSE.txt" ]]; then
        # Mensaje de clonación exitosa de la licencia
        if [[ "$laguage" == "esp" ]]; then
            echo "[#] Licencia instalada correctamente 'autonetplan -l' para leerla."
        else
            echo "[#] License successfully installed "autonetplan -l" to read it."
        fi
    else
        # Mensaje si la clonación no se realizó correctamente
        if [[ "$laguage" == "esp" ]]; then
            echo -e "[\e[31m#\e[0m] No se ha clonado la licencia correctamente, intentando de nuevo..."
            # Espera 1 segundo antes de intentar de nuevo
            sleep 1
        else
            echo -e "[\e[31m#\e[0m] Failed to clone license successfully, trying again..."
            sleep 1
        fi
    fi
done

# Crear ruta copias de seguridad
while [[ ! -d "$PROGRAM_FILES/autonetplan-backups" ]]; do
    # Clonar el archivo de licencia
    sudo mkdir "$PROGRAM_FILES/autonetplan-backups"
    # Verificacion de creacion
    if [[ -d "$PROGRAM_FILES/autonetplan-backups" ]]; then
        # Mensaje creacion almacenamiento copias de seguridad
        if [[ "$laguage" == "esp" ]]; then
            echo "[#] Ruta clonacion copias de seguridad, creada exitosamente"
        else
            echo "[#] Backup clone path, successfully created".
        fi
    else
        # Mensaje si la creacion no se realizó correctamente
        if [[ "$laguage" == "esp" ]]; then
            echo -e "[\e[31m#\e[0m] Ha ocurrido un error en la creacion, intentando de nuevo..."
            # Espera 1 segundo antes de intentar de nuevo
            sleep 1
        else
            echo -e "[\e[31m#\e[0m] An error occurred during creation, please try again..."
            sleep 1
        fi
    fi
done

# Verificar si el programa de integridad de dir-file-search existe en la ruta indicada
if [[ -f "$INSTALL_DIR/auto-netplan/program-files/dir-file-search.sh" ]]; then
    # Si el archivo existe, mostrar un mensaje indicando que ya está presente
    if [[ "$laguage" == "esp" ]]; then
        echo "[#] El script de integridad ya existe en $INSTALL_DIR/auto-netplan/program-files/dir-file-search.sh"
    else
        echo "[#] Integrity script already exists in $INSTALL_DIR/auto-netplan/program-files/dir-file-search.sh"
    fi
else
    if [[ "$laguage" == "esp" ]]; then
        echo -e "[\e[31m#\e[0m] El fichero dir-file-search.sh no existe, creando..."
    else
        echo -e "[\e[31m#\e[0m] The file dir-file-search.sh does not exist, creating..."
    fi
    # Si el archivo no existe, intentar copiarlo y renombrarlo
    sudo cp "$SCRIPT_DIR/auto-netplan/dir-file-search.sh" "$INSTALL_DIR/auto-netplan/program-files/dir-file-search.sh"
    if [[ -f "$INSTALL_DIR/autonetplan" ]]; then
        # Indicar existencia de fichero
        if [[ "$laguage" == "esp" ]]; then
            echo "[#] El fichero de integridad ha sido creado existosamente"
        else
            echo "[#] The integrity file has been successfully created."
        fi
        # Dar permisos de ejecución al script de integridad
        sudo chmod +x "$INSTALL_DIR/auto-netplan/program-files/dir-file-search.sh"
        # Mensaje tras otorgar correctamente los permisos
        if [[ "$laguage" == "esp" ]]; then
            echo "[#] Permisos necesarios otorgados al fichero de integridad correctamente"
        else
            echo "[#] Necessary permissions granted to the integrity file successfully".
        fi
    else
        # Mensaje si la copia no se realizó correctamente
        if [[ "$laguage" == "esp" ]]; then
            echo -e "[\e[31m#\e[0m] No se ha copiado el script de integridad correctamente, intentando de nuevo..."
            # Espera 1 segundo antes de intentar de nuevo
            sleep 1
        else
            echo -e "[\e[31m#\e[0m] Failed to copy integrity script successfully, try again..."
            # wait 1 second before trying again
            sleep 1
        fi
    fi
fi

# Funcion pausa
function pause(){
   read -p "$*"
}
#Espacio diferencial de texto
echo ""
# Llamada a funcion previa
if [[ "$laguage" == "esp" ]]; then
    pause 'Presione cualquier tecla para continuar...'
else
    pause 'Press any key to continue...'
fi
# Limpiar consola
clear
# Mensaje muestra de licencia
sudo less LICENSE.txt
# Limpiar consola
clear

# Revision de integridas de ficheros
# Revisar la correcta instalacion de cada uno de los ficheros NECESARIOS para el funcionamiento del programa
function autonetplan-necessary-integrity(){
    # Variables
    var_inter="[autonetplan-integrity]"
    # Inicio de funcion
    if [[ "$laguage" == "esp" ]]; then
        echo "[#] Revision de integridad del programa..."
    else
        echo "[#] Program integrity check..."
    fi
    if [[ -f "/usr/local/sbin/autonetplan" ]]; then
        # Si el fichero existe
        if [[ "$laguage" == "esp" ]]; then
            echo -e "[\e[32m#\e[0m] $var_inter El fichero autonetplan se ha instalado correctamente"
        else
            echo -e "[\e[32m#\e[0m] $var_inter The autonetplan file has been successfully installed."
        fi
        # primera variable de ok
        autone=ok
    else
        # Si no se ha encontrado
        if [[ "$laguage" == "esp" ]]; then
            echo -e "[\e[31m#\e[0m] $var_inter El fichero autonetplan no se ha encontrado en el sistema"
            sleep 1
        else
            echo -e "[\e[31m#\e[0m] $var_inter The autonetplan file was not found on the system."
            sleep 1
        fi
    fi
    if [[ -f $CONFIG_FILES/autonetplan/autonetplan.conf ]]; then
        # Si el fichero existe
        if [[ "$laguage" == "esp" ]]; then
            echo -e "[\e[32m#\e[0m] $var_inter El fichero de configuracion se ha instalado correctamente"
        else
            echo -e "[32m] $var_inter The configuration file has been successfully installed".
        fi
        # segunda variable de ok
        autoconf=ok
    else
        # Si no se ha encontrado
        if [[ "$laguage" == "esp" ]]; then
            echo -e "[\e[31m#\e[0m] $var_inter El fichero de configuracion no se ha encontrado en el sistema"
        else
            echo -e "[\e[31m#\e[0m] $var_inter The configuration file was not found on the system".
        fi
        sleep 1
    fi
    if [[ -f $PROGRAM_FILES/program-files/dir-file-search.sh ]]; then
        # Si el fichero existe
        if [[ "$laguage" == "esp" ]]; then
            echo -e "[\e[32m#\e[0m] $var_inter El fichero dir-file-search.sh se ha instalado correctamente"
        else
            echo -e "[\e[32m#\e[0m] $var_inter The file dir-file-search.sh has been successfully installed."
        fi
        # tercera variable de ok
        autodirfilesearch=ok
    else
        # Si no se ha encontrado
        if [[ "$laguage" == "esp" ]]; then
            echo -e "[\e[31m#\e[0m] $var_inter El fichero dir-file-search.sh no se ha encontrado en el sistema"
        else
            echo -e "[\e[31m#\e[0m] $var_inter The file dir-file-search.sh was not found on the system."
        fi
        sleep 1
    fi
}

function purge-repo(){
    # Tras la instalacion, el instalador, preguntara si borrar el repositorio clonado para liberar espacio
    if [[ "$laguage" == "esp" ]]; then
        read -p "¿Desea borrar el repositorio clonado? [s/n]: " deleteRepos
    else
        read -p "Do you want to delete the cloned repository? [y/n]: " deleteRepos
    fi
    
    if [[ $deleteRepos == "s" || $deleteRepos == "S" || $deleteRepos == "y" || $deleteRepos == "Y" ]]; then
    # Verificar si la ruta $SCRIPT_DIR existe
        if [[ -d "$SCRIPT_DIR" ]]; then
            # Si la ruta existe, eliminar de forma recursiva el directorio
            sudo rm -rf "$SCRIPT_DIR"
            # Mensaje de eliminación exitosa
            if [[ "$laguage" == "esp" ]]; then
                echo "[#] Se ha eliminado de forma recursiva el repositorio clonado."
            else
                echo "[#] The cloned repository has been recursively deleted."
            fi
        else
            # Si la ruta no existe, mostrar un mensaje indicando que no existe
            if [[ "$laguage" == "esp" ]]; then
                echo "[#] La ruta "$SCRIPT_DIR" no existe."
            else
                echo "[#] The path "$SCRIPT_DIR" does not exist."
            fi
        fi
    else
        if [[ "$laguage" == "esp" ]]; then
            echo "El repositorio no se eliminara del sistema"
        else
            echo "The repository will not be removed from the system"
        fi
    fi
}

# Llamada a la funcion autonetplan-necessary-integrity
autonetplan-necessary-integrity

# Si todos los ficheros necesarios para la instalacion estan "ok", preguntar si eliminar el repositorio

if [[ $autone == "ok" && $autoconf == "ok" && $autodirfilesearch == "ok" ]]; then
    # Los programas mas importantes se ha instalado correctamente
    if [[ "$laguage" == "esp" ]]; then
        echo -e "[\e[32m#\e[0m] Todos los ficheros mas importantes del programa se han instalado correctamente"
    else
        echo -e "[\e[32m#\e[0m] All the most important files of the program have been successfully installed".
    fi
    # Llamar a la funcion purge-repo
    purge-repo
    # Programa instalado correctamente
    if [[ "$laguage" == "esp" ]]; then
        echo -e "[\e[32m#\e[0m] Programa instalado correctamente."
    else
        echo -e "[\e[32m#\e[0m] Program successfully installed."
    fi
elif [[ $autone == "ok" ]]; then
    # Si este funciona al menos, enviar aviso de ok
    if [[ "$laguage" == "esp" ]]; then
        echo -e "[\e[32m#\e[0m] El fichero autonetplan se ha econtrado en la ruta correcta, puede ser llamado mediante 'autoentplan <parametros>'."
    else
        echo -e "[\e[32m#\e[0m] The autonetplan file has been found in the correct path, it can be called by 'autoentplan <parameters>'."
    fi
else
    # Ha ocurrido un error
    if [[ "$laguage" == "esp" ]]; then
        echo -e "[\e[31m#\e[0m] Ha ocurrido un error, puede que alguno de los ficheros no se encuentre en el sistema, revisar la integridad del programa."
    else
         echo -e "[\e[31m#\e[0m] An error has occurred, some of the files may not be found in the system, check the integrity of the program."
    fi
fi

if [[ "$laguage" == "esp" ]]; then
    echo "[#] Las rutas del programa son: '$INSTALL_DIR/autonetplan' y '/etc/autonetplan'"
    echo "[#] Mostrar la lista de ayuda del programa autonetplan, ejecute el comando: 'autonetplan -h'"
else
    echo "[#] The program paths are: '$INSTALL_DIR/autonetplan' and '/etc/autonetplan'"
    echo "[#] Display the autonetplan program help list, run the command: 'autonetplan -h'"
fi