#!/bin/bash

# Ruta de ficheros del programa
program_files="/usr/local/sbin/auto-netplan"
# Idioma del programa
language=$(cat "$program_files/program-files/language.lg")
# Ultima version
response=$(curl -s https://api.github.com/repos/Nisamov/autonetplan/releases/latest)
# Lastest tag
latest_tag=$(echo "$response" | jq -r .tag_name)
# Extraccion
latest_version=$(echo "$latest_tag" | sed -n 's/v\?\([0-9]\+\.[0-9]\+\.[0-9]\+\).*/\1/p')
# Ruta de descarga ( Se ha seleccionado esta para tras la descarga, desinstalar el previo e instalar esa otra version, por lo tanto, no afectaria al programa recien descargado )
# Ejemplo de como deberia quedar: /home/autonetplan/autonetplan_0.9.0 ( solo en descargas de ultima version )
downloadrute_lookback="/home/$USER/autonetplan_$latest_version"

if [[ "$1" == "-v" || "$1" == "--version" ]]; then
    if [[ $language == "ESP" ]]; then
        echo "test"
    else
        echo "test"
    fi
elif [[ "$1" == "-l" || "$1" == "--lastest" ]]; then

    # Clonar repo
    git clone
    # Preguntar donde guardar version con un read -p

    if [[ $language == "ESP" ]]; then
    # Ultima version oficial
    # Clonar lastest
    # La ruta será una nueva, creada proximamente
        sudo git clone -b "$latest_version" --single-branch "https://github.com/Nisamov/autonetplan" "$descargarutaversion"
    # Supuesto resultado
    # sudo git clone -b "0.9.0" --single-branch "https://github.com/Nisamov/autonetplan"
    else
        sudo git clone -b "$latest_version" --single-branch "https://github.com/Nisamov/autonetplan" "$descargarutaversion"
    fi
fi