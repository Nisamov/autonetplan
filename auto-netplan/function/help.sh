#!/bin/bash

# Ruta de ficheros del programa
program_files="/usr/local/sbin/auto-netplan"
# Idioma del programa
language=$(cat $program_files/program-files/language.lg)
# Programas bifurcados del codigo original
aune_bifurcation_route="/usr/local/sbin/auto-netplan/function"

function aune-help(){
    # Comprobar que el fichero existe
    if [[ -f "$program_files/program-files/autonetplan.help" ]]; then
        # Mostrar fichero con posibilidad de subir o bajar en la lectura
        sudo less $program_files/program-files/autonetplan.help
    else
    # Aviso de problema (no crear fichero - tiempo innecesario)
        if [[ $language == "ESP" ]]; then
            echo -e "[\e[31m#\e[0m] Error, fichero de soporte no encontrado."
        elif [[ $language == "ENG" ]]; then
            echo -e "[\e[31m#\e[0m] Error, support file not found".
        else
            echo "[#] Idioma no registrado / Laguage not registered."
            sudo bash "$aune_bifurcation_route/language-registration.sh"
        fi
    fi
}

# Llamada a la funcion aune-help
aune-help