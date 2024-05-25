#!/bin/bash

# Ruta de ficheros del programa
program_files="/usr/local/sbin/auto-netplan"
temp_cloned="/usr/local/sbin/auto-netplan/temp/"
# Idioma del programa
language=$(cat $program_files/program-files/language.lg)

# Instalar git
sudo apt install git
# Crear deposito temporal
while [[ ! -d "$temp_cloned" ]]; do
    sudo mkdir "$temp_cloned"
    if [[ -d $temp_cloned ]]; then
        # Descargar version mas reciente
        git clone "https://github.com/Nisamov/autonetplan" "$temp_cloned"
        # Eliminar y distribuir ficheros
        # Preguntar si guardar datos de la configuracion en /etc/autonetplan/autonetplan.conf
        if [[ $language == "ESP" ]]; then
            read -p "[?] Desea mantener la configuracion del software? [s/n]: " mantainconf
        elif [[ $language == "ENG" ]]; then
            read -p "[?] Do you want to keep the software configuration? [y/n]: " mantainconf
        else
            read -p "[?] Do you want to keep the software configuration? [y/n]: " mantainconf
        fi

        if [[ $mantainconf == "s" || $mantainconf == "y" ]]; then
            sudo bash "$aune_bifurcation_route/auto-update.sh"
        else
            if [[ $language == "ESP" ]]; then
                echo "[#] No se mantendra la configuracion del software."
            elif [[ $language == "ENG" ]]; then
                 echo "[#] The software configuration will not be saved"
            else
                echo "[#] The software configuration will not be saved"
            fi
        fi
        # Distribucion y reemplazo de ficheros
        sudo bash "$aune_bifurcation_route/update-replace-full.sh"
        # Fin
    else
        # No se ha creado la ruta correctamente, volver a intentar
        if [[ $language == "ESP" ]]; then
            echo "[#] La ruta temporal de actualizacion no se ha creado correctamente."
            echo "[#] Reintentando..."
        elif [[ $language == "ENG" ]]; then
            echo "[#] The temporary upgrade path has not been created correctly."
            echo "[#] Trying again..."
        fi
        pause 2
    fi
done

# Al sustituir ficheros, se borraran las configuraciones, regresando a las estandar
