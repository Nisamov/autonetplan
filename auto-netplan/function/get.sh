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
    # Crear un menu de seleccion dodne el usuario pueda ver y seleccionar (no interactuable, pero si de ingresar texto)
    echo "En pruebas"
elif [[ "$1" == "-l" || "$1" == "--lastest" ]]; then
    # Crear ruta
    sudo mkdir -r "$downloadrute_lookback"
    # Ultima version oficial
    sudo git clone -b "$latest_version" --single-branch "https://github.com/Nisamov/autonetplan" "$downloadrute_lookback"
fi