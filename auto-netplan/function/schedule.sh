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
# Ruta cron
cronrute="/etc/crontab"
# Fichero autonetplan del directorio autoneconf renombrado como autonetplan
program_config="/etc/autonetplan/autonetplan.conf"
# Configuracion de schedule - tiempo configuracion de tareas automaticas
opcionacdt=$(grep "^autonetplan-cron-default-time" "$program_config" | cut -d "=" -f2)


# Backup
backup_file="/usr/local/sbin/auto-netplan/function/backup.sh"
update_file="/usr/local/sbin/auto-netplan/program-files/auneupdate.sh"


function manualeditionconf(){
    if [[ $language == "ESP" ]]; then
        read -p "[?] ¿Desea editar la configuracion establecida? [s/n]: " confmancambio
        if [[ $confmancambio == "s" || $confmancambio == "S" ]]; then
            sudo nano "$program_config"   
        else
            echo "[#] Se ha denegado la edicion."
        fi
    else
        read -p "[?] You want to edit the configuration set? [y/n]: " confmancambio
        if [[ $confmancambio == "y" || $confmancambio == "Y" ]]; then
            sudo nano "$program_config"
        else
            echo "[#] The edition has been denied."
        fi
    fi
}

if [[ $1 == "-b" || $1 == "--backup" ]]; then
    if [[ $language == "ESP" ]]; then
        echo "[#] Se ha seleccionado 'backup' como actividad programada."
        # Leer fichero de configuracion para saber cada cuanto tiene que realizar estas actividades
        echo "[#] Configuracion establecida para cron es: $opcionacdt."
    else
        echo "[#] 'Backup' mode selected."
        echo "[#] The configuration set for cron is: $opcionacdt."
    fi
    manualeditionconf


elif [[ $1 == "-u" || $1 == "--update" ]]; then
    if [[ $language == "ESP" ]]; then
        echo "[#] Se ha seleccionado 'update' como actividad programada."
        echo "[#] Configuracion establecida para cron es: $opcionacdt."
    else
        echo "[#] 'update' has been selected as a scheduled activity."
        echo "[#] The configuration set for cron is: $opcionacdt."
    fi
    manualeditionconf
fi

# Usar el contenido de $opcionacdt pasarlo a $cronrute

sudo bash -c "cat <<EOF >> '$cronrute'
# AutoNetplan cron use
$opcionacdt
EOF"

if [[ $language == "ESP" ]]; then
    echo "[#] Configuracion aplicada en '$cronrute'."
else
    echo "[#] Configuration applied in '$cronrute'."
fi