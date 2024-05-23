#!/bin/bash

# Ruta de programa
work_dir="/usr/local/sbin"
# Ruta de ficheros del programa
program_files="/usr/local/sbin/auto-netplan"
# Fichero autonetplan del directorio autoneconf renombrado como autonetplan
program_config="/etc/autonetplan/autonetplan.conf"
# Idioma del programa
language=$(cat $program_files/program-files/language.lg)
# Programas bifurcados del codigo original
aune_bifurcation_route="/usr/local/sbin/auto-netplan/function"

function aune-remove(){
    # Revisar en el fichero de configuracion si la opcion autonetplan-prevent-purge-on-mistake es true o false
    # Buscar la opcion autonetplan-prevent-purge-on-mistake en el archivo de configuracion
    opcion=$(grep "^autonetplan-prevent-purge-on-mistake" "$program_config" | cut -d "=" -f2)
    # Comprobar si la opcion esta establecida en true o false
    if [ "$opcion" == "true" ]; then
        # Accion si la opcion es true
        if [[ $language == "ESP" ]]; then
            echo "[#] La opcion autonetplan-prevent-purge-on-mistake esta configurada como true."
        elif [[ $language == "ENG" ]]; then
            echo "[#] The autonetplan-prevent-purge-on-mistake option is set to true."
        else
            echo "[#] Idioma no registrado / Laguage not registered."
            sudo bash "$aune_bifurcation_route/language-registration.sh"
        fi
    elif [ "$opcion" == "false" ]; then
        # Accion si la opcion es false
        if [[ $language == "ESP" ]]; then
            echo "[#] La opcion autonetplan-prevent-purge-on-mistake esta configurada como false."
            echo -e "[\e[31m#\e[0m] Autonetplan esta siendo desinstalado..."
        elif [[ $language == "ENG" ]]; then
            echo "[#] The autonetplan-prevent-purge-on-mistake option is set to false."
            echo -e "[\e[31m#\e[0m] Autonetplan is being uninstalled..."
        else
            echo "[#] Idioma no registrado / Laguage not registered."
            sudo bash "$aune_bifurcation_route/language-registration.sh"
        fi

        # Funcion desinstalar programa
        sudo rm -rf "$program_files"
        sudo rm -rf "$work_dir/autonetplan"
        sudo rm -rf "$program_config"
        sudo rm -rf "/etc/autonetplan"
        # Revisar si quedan ficheros del programa
        if [[ -d $program_files || -f $work_dir/autonetplan || -d $program_config ]]; then
            # Borrar forzosamente todos los ficheros o directorios
            sudo rm -rf "$program_files"
            sudo rm -rf "$work_dir/autonetplan"
            sudo rm -rf "$program_config"
        else
            if [[ $language == "ESP" ]]; then
                echo -e "[\e[32m#\e[0m] Programa desinstalado correctamente."
            elif [[ $language == "ENG" ]]; then
                echo -e "[\e[32m#\e[0m] Program successfully uninstalled."
            else
                # Esto indica la desinstalacion del programa, no hay que pedir el idioma
                if [[ $language == "ESP" ]]; then
                    echo -e "[\e[32m#\e[0m] Programa desinstalado correctamenterogram successfully uninstalled."
                elif [[ $language == "ESP" ]]; then
                    echo -e "[\e[32m#\e[0m] Program successfully uninstalled."
                else
                    echo -e "[\e[32m#\e[0m] Program successfully uninstalled."
                fi
            fi
        fi
    else
        echo -e "[\e[33m!\e[0m] La opcion autonetplan-formatted-on-call no esta definida correctamente en el archivo de configuracion."
        exit 2
    fi
}

# Llamada a la funcion aune-remove
aune-remove