#!/bin/bash

# Ruta de ficheros del programa
program_files="/usr/local/sbin/auto-netplan"
# Idioma del programa
language=$(cat "$program_files/program-files/language.lg")

# Verificar codigo de salida del software AutoNetplan

# Llamar al software
sudo bash "/usr/local/sbin/autonetplan" $1 $2 $3

# Revisar codigo de salida
# Output valor de salida
if [ $? -eq 0 ]; then
    if [[ $language == "ESP" ]]; then
        echo -e "[\e[32m#\e[0m] Ejecucion finalizada correctamente."
    else
        echo -e "[\e[32m#\e[0m] Execution successfully completed."
    fi
elif [ $? -eq 2 ]; then
    if [[ $language == "ESP" ]]; then
        echo -e "[\e[31m#\e[0m] Configuracion deshabilitada o inexistente."
    else
        echo -e "[\e[31m#\e[0m] Disabled or non-existent configuration."
    fi
fi