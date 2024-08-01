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

if [[ -f $program_config ]]: then
    echo -e "$yellow_debug $green_good program_config $equal $program_config"
else
    echo -e "$yellow_debug $red_error program_config $not_equal $program_config"
fi

if [[ -f $integrity_program ]]; then
    echo -e "$yellow_debug $green_good integrity_program $equal $integrity_program"
else
    echo -e "$yellow_debug $red_error integrity_program $not_equal $integrity_program"
fi