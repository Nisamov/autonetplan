#!/bin/bash

# Ruta de ficheros del programa
program_files="/usr/local/sbin/auto-netplan"
# Idioma del programa
language=$(cat "$program_files/program-files/language.lg")
response=$(curl -s https://api.github.com/repos/Nisamov/autonetplan/releases/latest)
latest_tag=$(echo "$response" | jq -r .tag_name)
latest_version=$(echo "$latest_tag" | sed -n 's/v\?\([0-9]\+\.[0-9]\+\.[0-9]\+\).*/\1/p')

read -p "Donde descargar version (prueba): " descargarutaversion

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