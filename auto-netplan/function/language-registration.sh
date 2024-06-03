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

function language-registration(){
    # Configuracion si no hay un idioma registrado
    # Este codiog se ejcutara cada vez que no se haya registrado el idioma o no se encuentre correctamente registrado
    while true; do
        # Se les preguntara un idioma a registrar
        read -p "[#] Seleccione su lenguaje / Select your language [esp / eng]: " languageregistration
        if [[ $languageregistration == "esp" ]]; then
            # Escribir "ESP" en el fichero
            sudo cat <<EOF > "$program_files/program-files/language.lg"
ESP
EOF
        elif [[ $languageregistration == "eng" ]]; then
        # Escribir "ESP" en el fichero
            sudo cat <<EOF > "$program_files/program-files/language.lg"
ENG
EOF
        else
            echo "[#] Opcion invalida / Invalid option."
        fi
    done
}

# Llamar a la funcion
language-registration