#!/bin/bash

# Ruta de ficheros del programa
program_files="/usr/local/sbin/auto-netplan"
# Idioma del programa
language=$(cat $program_files/program-files/language.lg)


function change_program_language(){
    # Configuracion de cambio de idioma
    if [[ $language == "ESP" ]]; then
        read -p "¿Que idioma quiere establecer? [esp/eng]: " languageremodel
        if [[ $languageremodel == "esp" ]]; then
        sudo cat <<EOF > "$program_files/program-files/language.lg"
ESP
EOF
        echo "[#] Idioma cambiado a Español"
        elif [[ $languageremodel == "eng" ]]; then
        sudo cat <<EOF > "$program_files/program-files/language.lg"
ENG
EOF
        echo "[#] Language changed to English"
        fi
    elif [[ $language == "ENG" ]]; then
        read -p "What language do you want to set? [esp/eng]: " languageremodel
        if [[ $languageremodel == "esp" ]]; then
        sudo cat <<EOF > "$program_files/program-files/language.lg"
ESP
EOF
        echo "[#] Idioma cambiado a Español"
        elif [[ $languageremodel == "eng" ]]; then
        sudo cat <<EOF > "$program_files/program-files/language.lg"
ENG
EOF
        echo "[#] Language changed to English"
        fi
    else
        echo -e "[\e[31m#\e[0m] L46U4G3 N0T R3615T343D."
    fi
}

# Llamada a la funcion change_program_language
change_program_language