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

# Declaracion de variables
program_files="/usr/local/sbin/auto-netplan"
# Se usa el idioma ya usado en versiones previas
language=$(cat $program_files/program-files/language.lg)
#   Nueva version  (new version)
nwvsn="/usr/local/sbin/auto-netplan/temp"

# Comprobar existencia de fichero de version
if [[ -f "$nwvsn/program-files/version" ]]; then
    if [[ $language == "ESP" ]]; then
        echo "[#] Actualizando fichero de version..."
    elif [[ $language == "ENG" ]]; then
        echo "[#] Updating version file..."
    else
        echo "[#]Updating version file..." 
    fi
    # Eliminar fichero local
    sudo rm "$program_files/program-files/version"
    # Copiar fichero descargado a ruta indicada
    sudo cp "$nwvsn/program-files/version" "/usr/local/sbin/auto-netplan/program-files/version"
fi

# Comprobar fichero de configuracion
if [[ -f "$nwvsn/auneconf/autonetplan.conf" ]]; then
    if [[ $language == "ESP" ]]; then
        echo "[#] Actualizando fichero de configuracion..."
    elif [[ $language == "ENG" ]]; then
        echo "[#] Updating configuration file..."
    else
        echo "[#] Updating configuration file..."
    fi
    # Eliminar fichero de configuracion local
    sudo rm "/etc/autonetplan/autonetplan.conf"
    # Copiar fichero descargado a ruta indicada
    sudo cp "$nwvsn/auneconf/autonetplan.conf" "/etc/autonetplan/autonetplan.conf"
fi

# Comprobar fichero de manual
if [[ -f "$nwvsn/program-files/autonetplan.man" ]]; then
    if [[ $language == "ESP" ]]; then
        echo "[#] Actualizando fichero de manual..."
    elif [[ $language == "ENG" ]]; then
        echo "[#] Updating manual file..."
    else
        echo "[#] Updating manual file..."
    fi
    # Eliminar fichero manual local
    sudo rm "$program_files/program-files/autonetplan.man"
    # Copiar fichero descargado a ruta indicada
    sudo cp "$nwvsn/program-files/autonetplan.man" "$program_files/program-files/autonetplan.man"
fi

# Comprobar fichero de help
if [[ -f "$nwvsn/program-files/autonetplan.help" ]]; then
    if [[ $language == "ESP" ]]; then
        echo "[#] Actualizando fichero de ayuda..."
    elif [[ $language == "ENG" ]]; then
        echo "[#] Updating help file..."
    else
        echo "[#] Updating help file..."
    fi
    # Eliminar fichero local
    sudo rm "$program_files/program-files/autonetplan.help"
    # Copiar fichero descargado a ruta indicada
    sudo cp "$nwvsn/program-files/autonetplan.help" "$program_files/program-files/autonetplan.help"
fi

# Comprobar directorio de function
if [[ -d "$program_files/function" ]]; then
    if [[ $language == "ESP" ]]; then
        echo "[#] Actualizando directorio function..."
    elif [[ $language == "ENG" ]]; then
        echo "[#] Updating function directory..."
    else
        echo "[#] Updating function directory..."
    fi
    # Eliminar directorio funcion local
    sudo rm -rf "$program_files/function"
    # Copiar directorio descargado a ruta indicada
    sudo cp -r "$nwvsn/auto-netplan/function" "$program_files/function"
fi

# Comprobar fichero dir-file-search.sh
if [[ -f "$program_files/program-files/dir-file-search.sh" ]]; then
    if [[ $language == "ESP" ]]; then
        echo "[#] Actualizando fichero dir-file-search.sh..."
    elif [[ $language == "ENG" ]]; then
        echo "[#] Updating dir-file-search.sh file..."
    else
        echo "[#] Updating dir-file-search.sh file..."
    fi
    # Eliminar fichero local
    sudo rm "$program_files/program-files/dir-file-search.sh"
    # Copiar fichero descargado a ruta indicada
    sudo cp "$nwvsn/auto-netplan/dir-file-search.sh" "$program_files/program-files/dir-file-search.sh"
fi

# Comprobar fichero auneupdate.sh
if [[ -f "$program_files/program-files/auneupdate.sh" ]]; then
    if [[ $language == "ESP" ]]; then
        echo "[#] Actualizando fichero auneupdate.sh..."
    elif [[ $language == "ENG" ]]; then
        echo "[#] Updating auneupdate.sh file..."
    else
        echo "[#] Updating auneupdate.sh file..."
    fi
    # Eliminar fichero local
    sudo rm "$program_files/program-files/auneupdate.sh"
    # Copiar fichero descargado a ruta indicada
    sudo cp "$nwvsn/auto-netplan/auneupdate.sh" "$program_files/program-files/auneupdate.sh"
fi

# Comprobar fichero autonetplan
if [[ -f "/usr/local/sbin/autonetplan" ]]; then
    if [[ $language == "ESP" ]]; then
        echo "[#] Actualizando fichero autonetplan..."
    elif [[ $language == "ENG" ]]; then
        echo "[#] Updating autonetplan file..."
    else
        echo "[#] Updating autonetplan file..."
    fi
    # Eliminar fichero local
    sudo rm "/usr/local/sbin/autonetplan"
    # Copiar fichero descargado a ruta indicada
    sudo cp "$nwvsn/auto-netplan/autonetplan.sh" "/usr/local/sbin/autonetplan"
fi

# Finalizacion de actualizacion
if [[ $language == "ESP" ]]; then
    echo -e "[\e[32m#\e[0m] Actualizacion finalizada correctamente."
elif [[ $language == "ENG" ]]; then
    echo -e "[\e[32m#\e[0m] Update finished correctly."
else
    echo -e "[\e[32m#\e[0m] Update finished correctly."
fi