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

function changecrontime(){
    # Cambiar configuracion de cron
    if [[ $language == "ESP" ]]; then
        read -p "[?] Deseas cambiar la configuracion y los periodos de tiempo? [s/n]: " confmodify
    else
        read -p "[?] Do you want to change the settings and time periods? [y/n]: " confmodify
    fi

    if [[ $confmodify == "s" || $confmodify == "y" ]]; then
        if [[ $language == "ESP" ]]; then
            echo "[#] Ejemplo ingreso de parametros: 0 7 * * * (Ejecutar el script todos los días a las 7:00 AM)"
            read -p "[#] Ingrese los parametros a ingresar, separados por 1 espacio: " confsetup
        else
            echo "[#] Example of parameter input: 0 7 * * * * (Execute the script every day at 7:00 AM)"
            read -p "[#] Enter the parameters to be entered, separated by 1 space: " confsetup
        fi

        if [[ $language == "ESP" ]]; then
            read -p "[?] Esta es la configuracion que has ingresado '$confsetup', deseas proceder? [s/n]: " conformed
        else
            read -p "[?] his is the configuration you have entered '$confsetup', do you want to proceed? [y/n]: " conformed
        fi

        while [[ $conformed != "s" || $conformed != "y" ]]; do
            if [[ $language == "ESP" ]]; then
                echo "[#] Ejemplo ingreso de parametros: 0 7 * * * (Ejecutar el script todos los días a las 7:00 AM)"
                read -p "[#] Ingrese los parametros a ingresar, separados por 1 espacio: " confsetup
            else
                echo "[#] Example of parameter input: 0 7 * * * * (Execute the script every day at 7:00 AM)"
                read -p "[#] Enter the parameters to be entered, separated by 1 space: " confsetup
            fi

            if [[ $language == "ESP" ]]; then
                read -p "[?] Esta es la configuracion que has ingresado '$confsetup', deseas proceder? [s/n]: " conformed
            else
                read -p "[?] his is the configuration you have entered '$confsetup', do you want to proceed? [y/n]: " conformed
            fi
        done
            if [[ $language == "ESP" ]]; then
                echo "[#] Configurando fichero de configuracion..."
            else
                echo "[#] Configuring configuration file..."
            fi
            # Cambiar contenido de $opcionacdt por el definido previamente

    # Si no se desea cambiar la configuracion establecido en el .conf
    else
        if [[ $language == "ESP" ]]; then
            echo "[#] Se ha dejado la configuracion por defecto."
        else
            echo "[#] The default configuration has been left."
        fi
    fi
}


if [[ $1 == "backup" ]]; then
    if [[ $language == "ESP" ]]; then
        echo "[#] Se ha seleccionado 'backup' como actividad programada."
        # Leer fichero de configuracion para saber cada cuanto tiene que realizar estas actividades
        echo "[#] El tiempo por defecto establecido para cron es: $opcionacdt."
    else
        echo "[#] 'Backup' mode selected."
    fi
elif [[ $1 == "update" ]]; then
    if [[ $language == "ESP" ]]; then
        echo "[#] Se ha seleccionado 'update' como actividad programada."
        echo "[#] El tiempo por defecto establecido para cron es: $opcionacdt."
    else
        echo "[#] 'update' has been selected as a scheduled activity."
        echo "[#] The default time set for cron is: $opcionacdt."
    fi
    # Llamar a la funcion changecrontime
    changecrontime
fi


sudo bash -c "cat <<EOF >> '$cronrute'

EOF"