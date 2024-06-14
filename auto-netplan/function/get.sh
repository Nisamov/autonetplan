#!/bin/bash

# Ruta de ficheros del programa
program_files="/usr/local/sbin/auto-netplan"
# Idioma del programa
language=$(cat "$program_files/program-files/language.lg")

if [[ "$1" == "-v" || "$1" == "--version" ]]; then
    if [[ $language == "ESP" ]]; then
        echo "test"
    else
        echo "test"
    fi
elif [[ "$1" == "-l" || "$1" == "--lastest" ]]; then

    response=$(curl -s https://api.github.com/repos/Nisamov/autonetplan/releases/latest)
    latest_tag=$(echo "$response" | jq -r .tag_name)
    latest_version=$(echo "$latest_tag" | sed -n 's/v\?\([0-9]\+\.[0-9]\+\.[0-9]\+\).*/\1/p')
    # Clonar repo
    git clone
    # Preguntar donde guardar version con un read -p

    if [[ $language == "ESP" ]]; then
    # Ultima version oficial
 
    else
        echo "test"
    fi
fi