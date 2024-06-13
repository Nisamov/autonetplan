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
    if [[ $language == "ESP" ]]; then
        echo "test"
    else
        echo "test"
    fi
fi