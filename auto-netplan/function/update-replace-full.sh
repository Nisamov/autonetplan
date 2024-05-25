#!/bin/bash

# Declaracion de variables
program_files="/usr/local/sbin/auto-netplan"
# Se usa el idioma ya usado en versiones previas
language=$(cat $program_files/program-files/language.lg)
#   Nueva version  (new version)
nwvsn="/usr/local/sbin/auto-netplan/temp"

# Contenido a reemplazar
#   version [done]
#   Todos los ficheros .sh
#   Fichero de configuracion [done]
#   Fichero .help
#   Fichero .man

# Comprobar existencia de ficheros
if [[ -f "$nwvsn/program-files/version" ]]; then
    # Eliminar fichero local
    sudo rm "/usr/local/sbin/auto-netplan/program-files/version"
    # Copiar fichero descargado a ruta indicada
    sudo cp "$nwvsn/program-files/version" "/usr/local/sbin/auto-netplan/program-files/version"
fi

#   Comprobar fichero de configuracion
if [[ -f "$nwvsn/auneconf/autonetplan.conf" ]]; then
    # Eliminar fichero de configuracion local
    sudo rm "/etc/autonetplan/autonetplan.conf"
    # Copiar fichero descargado a ruta indicada
    sudo cp "$nwvsn/auneconf/autonetplan.conf" "/etc/autonetplan/autonetplan.conf"
fi

if [[ $language == "ESP" ]]; then
    echo -e "[\e[32m#\e[0m] Actualizacion finalizada correctamente."
elif [[ $language == "ENG" ]]; then
    echo -e "[\e[32m#\e[0m] Update finished correctly."
else
    echo -e "[\e[32m#\e[0m] Update finished correctly."
fi