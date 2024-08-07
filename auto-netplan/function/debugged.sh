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

# Este codigo permite revisar y mostrar informacion mas detallada del estado debug

# Declaracion variable directorio de configuracion netplan
# Rutas importantes a revisar con debug, cuentan con doble vairbale para revisar el ocrrecto funcionamiento
# Muchas de estas rutas son absurdas, siendo que no funcionarian muchas cosas si no existieran, pero siempre viene bien tener la ruta, por ende estan colocadas

# Ruta de ficheros del programa
program_files="/usr/local/sbin/auto-netplan"
# Fichero autonetplan del directorio autoneconf renombrado como autonetplan
program_config="/etc/autonetplan/autonetplan.conf"
# Ruta de programa revision integridad de autonetplan
integrity_program="/usr/local/sbin/auto-netplan/program-files/dir-file-search.sh"
# Ruta de ultima version
current_version=$(cat "$program_files/program-files/version")
# Idioma del programa
language=$(cat "$program_files/program-files/language.lg")
# Programas bifurcados del codigo original
aune_bifurcation_route="/usr/local/sbin/auto-netplan/function"
# Revisar dentro del fichero la ruta de configuracion de red
network_dir=$(grep "^autonetplan-netplan-route-config" "$program_config" | cut -d "=" -f2)
# Auto actualizaciones del programa
auto_update=$(grep "^autonetplan-update-program" "$program_config" | cut -d "=" -f2)
# IP a color
ip_colored=$(grep "^autonetplan-ip-colored" "$program_config" | cut -d "=" -f2)
# Actualizar paquetes
opcionaau=$(grep "^autonetplan-automate-update" "$program_config" | cut -d "=" -f2)
# Configuracion de schedule - tiempo configuracion de tareas automaticas
opcionacdt=$(grep "^autonetplan-cron-default-time" "$program_config" | cut -d "=" -f2)
# Revisar en configuracion si autonetplan-formatted-on-call es true o false
opcionafoc=$(grep "^autonetplan-formatted-on-call" "$program_config" | cut -d "=" -f2)
# Revisar en configuracion si autonetplan-automate-backup es true o false
opcionaab=$(grep "^autonetplan-automate-backup" "$program_config" | cut -d "=" -f2)

# Inicio de codigo

# Limpieza de consola
clear

# Ejemplo de mustra:
# [DEBUG] [good] [variable name] [variable content]
# [DEBUG] [error] [variable name] [variable content]

# [DEBUG] [good] work_dir == "/usr/local/sbin"
#|------| |----| |------|    |----------------|
# Amarillo verde blanco        blanco

#   [\e[31m#\e[0m] >> # rojo
#   [\e[33m!\e[0m] >> ! amarillo
#   [\e[32m#\e[0m] >> # verde

yellow_debug="[\e[33mDEBUG\e[0m]"
green_good="[\e[32mGood\e[0m]"
red_error="[\e[31mError\e[0m]"
equal="=="
not_equal="!="

if [[ -d $program_files ]]; then
    echo -e "$yellow_debug $green_good program_files $equal $program_files"
else
    echo -e "$yellow_debug $red_error program_files $not_equal $program_files"
fi

if [[ -f $program_config ]]; then
    echo -e "$yellow_debug $green_good program_config $equal $program_config"
else
    echo -e "$yellow_debug $red_error program_config $not_equal $program_config"
fi

if [[ -f $integrity_program ]]; then
    echo -e "$yellow_debug $green_good integrity_program $equal $integrity_program"
else
    echo -e "$yellow_debug $red_error integrity_program $not_equal $integrity_program"
fi

# Simplemente sirve para comparar que exista el fichero, no la version, pues esta puede variar
if [[ -f "$program_files/program-files/version" ]]; then
    echo -e "$yellow_debug $green_good current_version $equal $current_version"
else
    echo -e "$yellow_debug $red_error current_version $not_equal $current_version  | [\e[31mNot exist\e[0m]"
fi

    # Formato de display diferente
    # [DEBUG] [good]   [ESP]     work_dir == "/usr/local/sbin"
    #|------| |----|  |-----|    |----------------------------|
    # Amarillo verde bandera esp        blanco
    # [DEBUG] [good]   [ENG]     work_dir == "/usr/local/sbin"
    #|------| |----|  |-----|    |----------------------------|
    # Amarillo verde bandera eng        blanco

yellow_is="\e[33mS\e[0m"
red_ie="\e[31mE\e[0m"
red_ip="\e[31mP\e[0m"
blue_ig="\e[34mG\e[0m"
white_in="\e[37mN\e[0m"
yellow_beware="[\e[33m!!\e[0m]" # Simbolos que advierten al usuario que podria estar viendo una ruta incorrecta (pues no depende del software escribirla, sino del propio usuario)

if [[ $language == "ESP" ]]; then
    echo -e "$yellow_debug $green_good [${red_ie}${yellow_is}${red_ip}] language $equal $language"
elif [[ $language == "ENG" ]]; then
    # Referencia a la bandera de inlgaterra - rojo blanco azul
    echo -e "$yellow_debug $green_good [${red_ie}${white_in}${blue_ig}] current_version $equal $language"
else
    echo -e "$yellow_debug $red_error language $not_equal $language | [\e[31mNot exist\e[0m]"
fi

if [[ -d $aune_bifurcation_route ]]; then
    echo -e "$yellow_debug $green_good aune_bifurcation_route $equal $aune_bifurcation_route"
else
    echo -e "$yellow_debug $red_error aune_bifurcation_route $not_equal $aune_bifurcation_route | [\e[31mNot exist\e[0m]"
fi

# Mostrar contenido de variable y revisar que no esté vacía
if [[ -n $network_dir ]]; then
    echo -e "$yellow_debug $green_good $yellow_beware network_dir $equal $network_dir"
else
    echo -e "$yellow_debug $red_error anetwork_dir $not_equal $network_dir | [\e[31mNot exist\e[0m]"
fi

if [[ -n $auto_update ]]; then
    echo -e "$yellow_debug $green_good $yellow_beware auto_update $equal $auto_update"
else
    echo -e "$yellow_debug $red_error auto_update $not_equal $auto_update | [\e[31mNot exist\e[0m]"
fi

if [[ -n $ip_colored ]]; then
    if [[ $ip_colored == "true" ]]; then
        echo -e "$yellow_debug $green_good $yellow_beware ip_colored $equal $ip_colored"
    elif [[ $ip_colored == "false" ]]; then
        echo -e "$yellow_debug $red_error ip_colored $not_equal $ip_colored [\e[33mService Unabled\e[0m]"
    fi
else
    echo -e "$yellow_debug $red_error ip_colored $not_equal $ip_colored | [\e[31mNot exist\e[0m]"
fi

if [[ -n $opcionaau ]]; then
    if [[ $opcionaau == "true" ]]; then
        echo -e "$yellow_debug $green_good $yellow_beware opcionaau $equal $opcionaau"
    elif [[ $opcionaau == "false" ]]; then
        echo -e "$yellow_debug $red_error opcionaau $not_equal $opcionaau [\e[33mService Unabled\e[0m]"
    fi
else
    echo -e "$yellow_debug $red_error opcionaau $not_equal $opcionaau | [\e[31mNot exist\e[0m]"
fi

if [[ -n $opcionacdt ]]; then
    echo -e "$yellow_debug $green_good $yellow_beware opcionacdtu $equal $opcionacdt"
else
    echo -e "$yellow_debug $red_error opcionacdt $not_equal $opcionacdt | [\e[31mNot exist\e[0m]"
fi

if [[ -n $opcionafo ]]; then
    if [[ $opcionafo == "true" ]]; then
        echo -e "$yellow_debug $green_good $yellow_beware opcionafo $equal $opcionafo"
    elif [[ $opcionafo == "false" ]]; then
        echo -e "$yellow_debug $red_error opcionafo $not_equal $opcionafo [\e[33mService Unabled\e[0m]"
    fi
else
    echo -e "$yellow_debug $red_error opcionafo $not_equal $opcionafo | [\e[31mNot exist\e[0m]"
fi

if [[ -n $opcionaab ]]; then
    if [[ $opcionaab == "true" ]]; then
        echo -e "$yellow_debug $green_good $yellow_beware opcionaab $equal $opcionaab"
    elif [[ $oopcionaab == "false" ]]; then
        echo -e "$yellow_debug $red_error opcionaab $not_equal $opcionaab [\e[33mService Unabled\e[0m]"
    fi
else
    echo -e "$yellow_debug $red_error opcionaab $not_equal $opcionaab | [\e[31mNot exist\e[0m]"
fi