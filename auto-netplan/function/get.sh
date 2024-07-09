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

if [[ "$1" == "-v" || "$1" == "--version" ]]; then
    # Pensar mas adelante

    # Mirar en github sobre versiones publicadas y dar a elegir entre las descargas
    echo "Funcion no disponible"

elif [[ "$1" == "-l" || "$1" == "--lastest" ]]; then
    # Ruta de descarga ( Se ha seleccionado esta para tras la descarga, desinstalar el previo e instalar esa otra version, por lo tanto, no afectaria al programa recien descargado )
    # Ejemplo de como deberia quedar: /home/autonetplan/autonetplan_0.9.0 ( solo en descargas de ultima version )
    downloadrute_lookback="/home/$USER/autonetplan_$latest_version"
    # Crear ruta
    mkdir "$downloadrute_lookback"
    # Ultima version oficial
    git clone -b "$latest_version" --single-branch "https://github.com/Nisamov/autonetplan" "$downloadrute_lookback"
    if [[ $language == "ESP" ]]; then
        echo "[#] El software ha sido descargado la ultima version en $downloadrute_lookback."
    else
        echo "[#] Software's lastes version installed in $downloadrute_lookback."
    fi
fi