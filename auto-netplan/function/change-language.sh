#!/bin/bash

#Copyright 2024 Andres Rulsan Abadias Otal
#
#Licensed under the Apache License, Version 2.0 (the "License");
#you may not use this file except in compliance with the License.
#You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
#Unless required by applicable law or agreed to in writing, software
#distributed under the License is distributed on an "AS IS" BASIS,
#WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#See the License for the specific language governing permissions and
#limitations under the License.

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