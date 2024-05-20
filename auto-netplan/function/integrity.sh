#!/bin/bash

# Fichero autonetplan del directorio autoneconf renombrado como autonetplan
program_config="/etc/autonetplan/autonetplan.conf"
# Ruta de programa revision integridad de autonetplan
integrity_program="/usr/local/sbin/auto-netplan/program-files/dir-file-search.sh"
# Idioma del programa
language=$(cat $program_files/program-files/language.lg)
# Programas bifurcados del codigo original
aune_bifurcation_route="/usr/local/sbin/auto-netplan/function"

function aune-integrity(){
    # Revisar que el fichero de configuracion exista
    if [[ -f $program_config ]]; then
        if [[ $language == "ESP" ]]; then
            echo "[#] Revisando el fichero de configuracion..."
        elif [[ $language == "ENG" ]]; then
            echo "[#] Reviewing the configuration file..."
        else
            echo "[#] Idioma no registrado / Laguage not registered."
            sudo bash "$aune_bifurcation_route/language-registration.sh"
        fi
        # Revisar dentro del fichero si la funcion de lectura de programas esta activada
        opcion_aes=$(grep "^autonetplan-enable-search" "$program_config" | cut -d "=" -f2)
        # Comprobar si la opcion esta establecida en true o false
        if [[ "$opcion_aes" == "true" ]]; then
            # Mensaje de depuracion
            if [[ $language == "ESP" ]]; then
                echo "[#] La opcion autonetplan-enable-search esta habilitada."
                # Ejecutar fichero de lectura integridad del programa
                echo "[#] Ejecutando el script de busqueda de archivos..."
            elif [[ $language == "ENG" ]]; then
                echo "[#] The autonetplan-enable-search option is enabled."
                echo "[#] Running the file search script..."
            else
                echo "[#] Idioma no registrado / Laguage not registered."
                sudo bash "$aune_bifurcation_route/language-registration.sh"
            fi
            sudo bash "$integrity_program"
        elif [[ "$opcion_aes" == "false" ]]; then
            if [[ $language == "ESP" ]]; then
                echo -e "[\e[31m#\e[0m] La funcion autonetplan-enable-search esta desactivada y no se puede continuar con la operacion."
            elif [[ $language == "ENG" ]]; then
                echo -e "[\e[31m#\e[0m] The autonetplan-enable-search function is disabled and the operation cannot be continued."
            else
                echo "[#] Idioma no registrado / Laguage not registered."
                sudo bash "$program_files/function/language-registration.sh"
            fi
        fi
    else
        if [[ $language == "ESP" ]]; then
        # Avisar de la inexistencia del fichero
            echo -e "[\e[31m#\e[0m] El fichero de configuracion no se ha encontrado."
        elif [[ $language == "ENG" ]]; then
            echo -e "[\e[31m#\e[0m] The configuration file was not found."
        else
            echo "[#] Idioma no registrado / Laguage not registered."
            sudo bash "$aune_bifurcation_route/language-registration.sh"
        fi
    fi
}

# Llamar a la funcion aune-integrity
aune-integrity