#!/bin/bash
# Por Andres Ruslan Abadias Otal

# Ruta de ficheros del programa
program_files="/usr/local/sbin/auto-netplan"
# Idioma del programa
language=$(cat $program_files/program-files/language.lg)
# Programas bifurcados del codigo original
aune_bifurcation_route="/usr/local/sbin/auto-netplan/function"

function aune-manual(){
    # Comprobar que el fichero existe
    if [[ -f "$program_files/program-files/autonetplan.man" ]]; then
        # Mostrar fichero con posibilidad de subir o bajar en la lectura
        sudo less $program_files/program-files/autonetplan.man
    else
    # Aviso de problema (no crear fichero - tiempo innecesario)
        if [[ $language == "ESP" ]]; then
            echo -e "[\e[31m#\e[0m] Error, manual no encontrado."
        elif [[ $language == "ENG" ]]; then
            echo -e "[\e[31m#\e[0m] Error, manual not found."
        else
            echo "[#] Idioma no registrado / Laguage not registered."
            sudo bash "$aune_bifurcation_route/language-registration.sh"
        fi
    fi
}

# Llamada a la funcion aune-manual
aune-manual