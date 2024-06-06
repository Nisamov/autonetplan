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

# La ruta de las acciones es la siguiente
# /usr/local/sbin/auto-netplan/progra-file/autonetplan-schedule/
# Ruta de ficheros del programa
program_files="/usr/local/sbin/auto-netplan"
# Idioma del programa
language=$(cat "$program_files/program-files/language.lg")
cronrute="/tmp/crontab.fJIfht/crontab"

if [[ $2 == "backup" ]]; then
    if [[ $language == "ESP" ]]; then
        echo "[#] Se ha seleccionado 'backup' como actividad programada."
        # Leer fichero de configuracion para saber cada cuanto tiene que realizar estas actividades
    else

    fi
elif [[ $2 == "update" ]]; then


fi


sudo bash -c "cat <<EOF >> '$cronrute'

EOF"