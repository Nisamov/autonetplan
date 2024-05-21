#!/bin/bash

# Declaracion variables
temp_cloned="/usr/local/sbin/auto-netplan/temp/"
# Idioma del programa
language=$(cat $program_files/program-files/language.lg)

# Instalar git
sudo apt install git
# Crear deposito temporal
while [[ ! -d $temp_cloned ]]; do
    sudo mkdir $temp_cloned
    if [[ -d $temp_cloned ]]; then
        # Descargar version mas reciente
        git clone "https://github.com/Nisamov/autonetplan" $temp_cloned
        # Eliminar y distribuir ficheros

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
