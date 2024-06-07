#!/bin/bash

# Copyright 2024 Andres Rulsan Abadias Otal
# Licensed under the Apache License, Version 2.0 (the "License");

# ESTO ES SOLO UNA PRUEBA PARA REVISAR EL FUNCIONAMIENTO DEL SCRIPT

# Declaracion de variables
program_files="/usr/local/sbin/auto-netplan"
nwvsn="/usr/local/sbin/auto-netplan/temp"

# Leer idioma
language=$(cat "$program_files/program-files/language.lg")

# Función para mostrar mensajes
function show_message {
    local message_esp=$1
    local message_eng=$2
    if [[ $language == "ESP" ]]; then
        echo "$message_esp"
    elif [[ $language == "ENG" ]]; then
        echo "$message_eng"
    else
        echo "$message_eng"
    fi
}

# Actualizar archivo de versión
if [[ -f "$nwvsn/program-files/version" ]]; then
    show_message "[#] Actualizando fichero de version..." "[#] Updating version file..."
    sudo rm "$program_files/program-files/version"
    sudo cp "$nwvsn/program-files/version" "$program_files/program-files/version"
fi

# Actualizar archivo de configuración
if [[ -f "$nwvsn/auneconf/autonetplan.conf" ]]; then
    show_message "[#] Actualizando fichero de configuracion..." "[#] Updating configuration file..."
    sudo rm "/etc/autonetplan/autonetplan.conf"
    sudo cp "$nwvsn/auneconf/autonetplan.conf" "/etc/autonetplan/autonetplan.conf"
fi

# Actualizar archivo de manual
if [[ -f "$nwvsn/program-files/autonetplan.man" ]]; then
    show_message "[#] Actualizando fichero de manual..." "[#] Updating manual file..."
    sudo rm "$program_files/program-files/autonetplan.man"
    sudo cp "$nwvsn/program-files/autonetplan.man" "$program_files/program-files/autonetplan.man"
fi

# Actualizar archivo de ayuda
if [[ -f "$nwvsn/program-files/autonetplan.help" ]]; then
    show_message "[#] Actualizando fichero de ayuda..." "[#] Updating help file..."
    sudo rm "$program_files/program-files/autonetplan.help"
    sudo cp "$nwvsn/program-files/autonetplan.help" "$program_files/program-files/autonetplan.help"
fi

# Actualizar directorio de funciones
if [[ -d "$program_files/function" ]]; then
    show_message "[#] Actualizando directorio function..." "[#] Updating function directory..."
    sudo rm -rf "$program_files/function"
    sudo cp -r "$nwvsn/auto-netplan/function" "$program_files/function"
fi

# Actualizar archivo dir-file-search.sh
if [[ -f "$program_files/program-files/dir-file-search.sh" ]]; then
    show_message "[#] Actualizando fichero dir-file-search.sh..." "[#] Updating dir-file-search.sh file..."
    sudo rm "$program_files/program-files/dir-file-search.sh"
    sudo cp "$nwvsn/auto-netplan/dir-file-search.sh" "$program_files/program-files/dir-file-search.sh"
fi

# Actualizar archivo auneupdate.sh
if [[ -f "$program_files/program-files/auneupdate.sh" ]]; then
    show_message "[#] Actualizando fichero auneupdate.sh..." "[#] Updating auneupdate.sh file..."
    sudo rm "$program_files/program-files/auneupdate.sh"
    sudo cp "$nwvsn/auto-netplan/auneupdate.sh" "$program_files/program-files/auneupdate.sh"
fi

# Actualizar archivo autonetplan
if [[ -f "/usr/local/sbin/autonetplan" ]]; then
    show_message "[#] Actualizando fichero autonetplan..." "[#] Updating autonetplan file..."
    sudo rm "/usr/local/sbin/autonetplan"
    sudo cp "$nwvsn/auto-netplan/autonetplan.sh" "/usr/local/sbin/autonetplan"
    
    # Intentar otorgar permisos
    if sudo chmod 755 "/usr/local/sbin/autonetplan"; then
        show_message "[#] Permisos aplicados correctamente." "[#] Permits applied correctly."
    else
        show_message "[#] Error al aplicar permisos." "[#] Error when applying permissions."
    fi
fi

# Finalizacion de actualizacion
show_message "[\e[32m#\e[0m] Actualizacion finalizada correctamente." "[\e[32m#\e[0m] Update finished correctly."
