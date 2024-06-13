#!/bin/bash

# Ruta de ficheros del programa
program_files="/usr/local/sbin/auto-netplan"
# Idioma del programa
language=$(cat "$program_files/program-files/language.lg")
# Ruta de las copias
backup_dir="autonetplan-backups"
# Revisar dentro del fichero la ruta de configuracion de red
network_dir=$(grep "^autonetplan-netplan-route-config" "$program_config" | cut -d "=" -f2)

function aune-backup(){
    # Comprobar existencia de ruta de backups
    if [[ $language == "ESP" ]]; then
        echo "[#] Revisando existencia de ruta $program_files/program-files/$backup_dir."
    elif [[ $language == "ESP" ]]; then
        echo "[#] Checking existence of path $program_files/program-files/$backup_dir."
    else
        echo "[#] Checking existence of path $program_files/program-files/$backup_dir."
    fi

    if [[ ! -d "$program_files/program-files/$backup_dir" ]]; then
        if [[ $language == "ESP" ]]; then
            echo -e "[\e[31m#\e[0m] Ruta no existente, creando ruta..."
        elif [[ $language == "ENG" ]]; then
            echo -e "[\e[31m#\e[0m] Non existing route, creating route..."
        else
            echo -e "[\e[31m#\e[0m] Non existing route, creating route..."
        fi
        # Crear ruta de copia de seguridad
        sudo mkdir -p "$program_files/program-files/$backup_dir"
    fi

    # Si existe previamente la ruta...
    if [[ -d "$program_files/program-files/$backup_dir" ]]; then
        if [[ $language == "ESP" ]]; then
            echo -e "[\e[32m#\e[0m] Ruta $program_files/program-files/$backup_dir existente."
        elif [[ $language == "ENG" ]]; then
            echo -e "[\e[32m#\e[0m] Existing $program_files/program-files/$backup_dir path."
        else
            echo -e "[\e[32m#\e[0m] Existing $program_files/program-files/$backup_dir path."
        fi
        # Generar un numero aleatorio para el nombre del archivo de copia de seguridad
        digited=$(($RANDOM%100))
        if [[ $language == "ESP" ]]; then
            echo "[#] Copiando fichero $network_dir..."
        elif [[ $language == "ENG" ]]; then
            echo "[#] Copying $network_dir file..."
        else
            echo "[#] Copying $network_dir file..."
        fi
        # Almacenar la copia de seguridad con un valor aleatorio para identificarla correctamente
        sudo cp "$network_dir" "$program_files/program-files/$backup_dir/network_backup_$digited.bk"
        if [[ -f "$program_files/program-files/$backup_dir/network_backup_$digited.bk" ]]; then
            if [[ $language == "ESP" ]]; then
                echo -e "[\e[32m#\e[0m] Copia de seguridad completada."
                echo "[#] La copia de seguridad se ha guardado como network_backup_$digited.bk en la ruta $program_files/program-files/$backup_dir."
            elif [[ $language == "ENG" ]]; then
                echo -e "[\e[32m#\e[0m] Backup completed."
                echo "[#] The backup has been saved as network_backup_$digited.bk in the path $program_files/program-files/$backup_dir."
            else
                echo -e "[\e[32m#\e[0m] Backup completed."
                echo "[#] The backup has been saved as network_backup_$digited.bk in the path $program_files/program-files/$backup_dir."
            fi
        else
            if [[ $language == "ESP" ]]; then
                echo -e "[\e[31m#\e[0m] La copia de seguridad ha fallado, asegurate que has referenciado correctamente la ruta en el fichero de configuracion '/etc/autonetplan/autonetplan.conf'"
            elif [[ $language == "ENG" ]]; then
                echo -e "[\e[31m#\e[0m] The backup has failed, make sure you have correctly referenced the path in the configuration file '/etc/autonetplan/autonetplan.conf'."
            else
                echo -e "[\e[31m#\e[0m] The backup has failed, make sure you have correctly referenced the path in the configuration file '/etc/autonetplan/autonetplan.conf'."
            fi
        fi
    else
        if [[ $language == "ESP" ]]; then
            echo -e "[\e[31m#\e[0m] Ha ocurrido un error inesperado."
        elif [[ $language == "ENG" ]]; then
            echo -e "[\e[31m#\e[0m] An unexpected error has occurred."
        else
            echo -e "[\e[31m#\e[0m] An unexpected error has occurred."
        fi
    fi
}

# Llamar a la funcion
aune-backup