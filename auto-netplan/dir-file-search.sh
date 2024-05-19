# Por Andres Abadias
# Programa de busqueda de ficheros para autonetplan

# Variables del programa
program_config=/etc/autonetplan/autonetplan.conf
program_files="/usr/local/sbin/auto-netplan"
language=$(cat $program_files/program-files/language.lg)

## Variables de mensajes
msg_revision="[Revision de datos]:"
msg_revision_eng="[Data review]:"

#red_msg="[\e[31m#\e[0m]"
#yellow_msg="[\e[33m#\e[0m]"
#green_msg="[\e[32m#\e[0m]"

# Declaracion de variable - registro de idioma
function language-registration(){
    # Configuracion si no hay un idioma registrado
    # Este codiog se ejcutara cada vez que no se haya registrado el idioma o no se encuentre correctamente registrado
    while true; do
        # Se les preguntara un idioma a registrar
        read -p "[#] Seleccione su lenguaje / Select your language [esp / eng]: " languageregistration
        if [[ $languageregistration == "esp" ]]; then
            # Escribir "ESP" en el fichero
            sudo cat <<EOF > "$program_files/program-files/language.lg"
ESP
EOF
        elif [[ $languageregistration == "eng" ]]; then
        # Escribir "ESP" en el fichero
            sudo cat <<EOF > "$program_files/program-files/language.lg"
ENG
EOF
        else
            echo "[#] Opcion invalida / Invalid option."
        fi
    done
}

# Iniciacion del programa
if [[ $language == "ESP" ]]; then
    echo -e "[\e[32m#\e[0m] $msg_revision Revision de integridad de datos del programa autonetplan en curso."
elif [[ $language == "ENG" ]]; then
    echo -e "[\e[32m#\e[0m] $msg_revision_eng Data integrity review of the ongoing autonetplan program."
else
    echo "[#] Idioma no registrado / Laguage not registered."
    language-registration
fi

# Revisar si el fichero de configuracion existe
if [[ -f $program_config ]]; then
    # Enviar mensaje de existencia de fichero de configuracion
    if [[ $language == "ESP" ]]; then
        echo "[#] $msg_revision En ejecucion"
    elif [[ $language == "ENG" ]]; then
        echo "[#] $msg_revision_eng Executing..."
    fi
    # Revisar si la opcion principal esta habilitada
    opcion_aes=$(grep "^autonetplan-enable-search" "$program_config" | cut -d "=" -f2)
    # Comprobar si la opcion esta establecida en true o false
    if [[ "$opcion_aes" == "true" ]]; then
        # Revisar si alguna de las otras dos opciones esta activa
        # Revisa en el siguiente orden: ficheros -> directorios -> rutas propias

        # Opcion 1 - Ficheros
        opcion_afe=$(grep "^autonetplan-file-existence" "$program_config" | cut -d "=" -f2)
        # Comprobar si la opcion esta establecida en true o false
        if [[ "$opcion_afe" == "true" ]]; then
            # Revisa los ficheros y su integridad
            # Busca fichero de configuracion
            opcion_fecf=$(grep "^file-existence-config-file" "$program_config" | cut -d "=" -f2)
            # Si el fichero existe
            if [[ -f $opcion_fecf ]]; then
                if [[ $language == "ESP" ]]; then
                    echo -e "[\e[32m#\e[0m] El fichero $opcion_fecf existe"
                elif [[ $language == "ENG" ]]; then
                    echo -e "[\e[32m#\e[0m] File $opcion_fecf exists"
                fi
            else
            # Si el fichero no existe
                if [[ $language == "ESP" ]]; then
                    echo -e "[\e[31m#\e[0m] No se ha encontrado $opcion_fecf"
                elif [[ $language == "ENG" ]]; then
                    echo -e "[\e[32m#\e[0m] File $opcion_fecf does not exist"
                fi
            fi
            # Busca fichero de programa
            opcion_feaf=$(grep "^file-existence-autonetplansh-file" "$program_config" | cut -d "=" -f2)
            # Si el fichero existe
            if [[ -f $opcion_feaf ]]; then
                if [[ $language == "ESP" ]]; then
                    echo -e "[\e[32m#\e[0m] El fichero $opcion_feaf existe"
                elif [[ $language == "ENG" ]]; then
                    echo -e "[\e[32m#\e[0m] File $opcion_feaf exists"
                fi
            else
            # Si el fichero no existe
                if [[ $language == "ESP" ]]; then
                    echo -e "[\e[31m#\e[0m] No se ha encontrado $opcion_feaf"
                elif [[ $language == "ENG" ]]; then
                    echo -e "[\e[31m#\e[0m] File $opcion_feaf does not exist"
                fi
            fi
            # Busca fichero de licencia
            opcion_felf=$(grep "^file-existence-license-file" "$program_config" | cut -d "=" -f2)
            # Si el fichero existe
            if [[ -f $opcion_felf ]]; then
                if [[ $language == "ESP" ]]; then
                    echo -e "[\e[32m#\e[0m] El fichero $opcion_felf existe"
                elif [[ $language == "ENG" ]]; then
                    echo -e "[\e[32m#\e[0m] File $opcion_felf exists"
                fi
            else
            # Si el fichero no existe
                if [[ $language == "ESP" ]]; then
                    echo -e "[\e[31m#\e[0m] No se ha encontrado $opcion_felf"
                elif [[ $language == "ENG" ]]; then
                    echo -e "[\e[31m#\e[0m] File $opcion_felf does not exist"
                fi
            fi
            # Busca el fcihero de version
            opcion_fevf=$(grep "^file-existence-version-file" "$program_config" | cut -d "=" -f2)
            # Si el fichero existe
            if [[ -f $opcion_fevf ]]; then
                if [[ $language == "ESP" ]]; then
                    echo -e "[\e[32m#\e[0m] El fichero $opcion_fevf existe"
                elif [[ $language == "ENG" ]]; then
                    echo -e "[\e[32m#\e[0m] File $opcion_fevf exists"
                fi
            else
            # Si el fichero no existe
                if [[ $language == "ESP" ]]; then
                    echo -e "[\e[31m#\e[0m] No se ha encontrado $opcion_fevf"
                elif [[ $language == "ENG" ]]; then
                    echo -e "[\e[31m#\e[0m] File $opcion_fevf does not exist"
                fi
            fi
            # Busca el fichero de idioma
            opcion_felaf=$(grep "^file-existence-language-file" "$program_config" | cut -d "=" -f2)
            # Si el fichero existe
            if [[ -f $opcion_felaf ]]; then
                if [[ $language == "ESP" ]]; then
                    echo -e "[\e[32m#\e[0m] El fichero $opcion_felaf existe"
                elif [[ $language == "ENG" ]]; then
                    echo -e "[\e[32m#\e[0m] File $opcion_felaf exists"
                fi
            else
            # Si el fichero no existe
                if [[ $language == "ESP" ]]; then
                    echo -e "[\e[31m#\e[0m] No se ha encontrado $opcion_felaf"
                elif [[ $language == "ENG" ]]; then
                    echo -e "[\e[31m#\e[0m] File $opcion_felaf does not exist"
                fi
            fi
            # Busca el fichero de actualizacion
            opcion_feuf=$(grep "^file-existence-update-file" "$program_config" | cut -d "=" -f2)
            # Si el fichero existe
            if [[ -f $opcion_feuf ]]; then
                if [[ $language == "ESP" ]]; then
                    echo -e "[\e[32m#\e[0m] El fichero $opcion_feuf existe"
                elif [[ $language == "ENG" ]]; then
                    echo -e "[\e[32m#\e[0m] File $opcion_feuf exists"
                fi
            else
            # Si el fichero no existe
                if [[ $language == "ESP" ]]; then
                    echo -e "[\e[31m#\e[0m] No se ha encontrado $opcion_feuf"
                elif [[ $language == "ENG" ]]; then
                    echo -e "[\e[31m#\e[0m] File $opcion_feuf does not exist"
                fi
            fi

        elif [[ "$opcion_afe" == "false" ]]; then
            # Aviso de configuracion deshabilitada
            if [[ $language == "ESP" ]]; then
                echo -e "[\e[31m#\e[0m] $msg_revision La configuracion autonetplan-file-existence esta desactivada."
            elif [[ $language == "ENG" ]]; then
                echo -e "[\e[31m#\e[0m] $msg_revision_eng The autonetplan-file-existence configuration is disabled."
            fi
        else
            if [[ $language == "ESP" ]]; then
                echo -e "[\e[31m#\e[0m] $msg_revision No se ha encontrado la linea autonetplan-file-existence."
            elif [[ $language == "ENG" ]]; then
                echo -e "[\e[31m#\e[0m] $msg_revision_eng The autonetplan-file-existence line was not found."
            fi
        fi

        # Opcion 2 - Directorios
        opcion_ade=$(grep "^autonetplan-directory-existence" "$program_config" | cut -d "=" -f2)
        # Comprobar si la opcion esta establecida en true o false
        if [[ "$opcion_ade" == "true" ]]; then
            # Revisa los directorios y su integridad
            # Busca directorio de configuracion
            opcion_decd=$(grep "^dir-existence-config-dir" "$program_config" | cut -d "=" -f2)
            if [[ -d $opcion_decd ]]; then
                # Si el directorio existe
                if [[ $language == "ESP" ]]; then
                    echo -e "[\e[32m#\e[0m] El directorio $opcion_decd existe"
                elif [[ $language == "ENG" ]]; then
                    echo -e "[\e[32m#\e[0m] Directory $opcion_decd exists"
                fi
            else
                # Si no existe
                if [[ $language == "ESP" ]]; then
                    echo -e "[\e[31m#\e[0m] No se ha encontrado $opcion_decd"
                elif [[ $language == "ENG" ]]; then
                    echo -e "[\e[31m#\e[0m] Directory $opcion_decd does not exist"
                fi
            fi
            # Buscar directorio de ficheros del programa
            opcion_depfd=$(grep "^dir-existence-program-files-dir" "$program_config" | cut -d "=" -f2)
            if [[ -d $opcion_depfd ]]; then
                # Si el directorio existe
                if [[ $language == "ESP" ]]; then
                    echo -e "[\e[32m#\e[0m] El directorio $opcion_depfd existe"
                elif [[ $language == "ENG" ]]; then
                    echo -e "[\e[32m#\e[0m] Directory $opcion_depfd exist"
                fi
            else
                # Si no existe
                if [[ $language == "ESP" ]]; then
                    echo -e "[\e[31m#\e[0m] No se ha encontrado $opcion_depfd"
                elif [[ $language == "ENG" ]]; then
                    echo -e "[\e[31m#\e[0m] Directory $opcion_depfd does not exist"
                fi
            fi
        elif [[ "$opcion_ade" == "false" ]]; then
            # Aviso de configuracion deshabilitada
            if [[ $language == "ESP" ]]; then
                echo -e "[\e[31m#\e[0m] $msg_revision La configuracion autonetplan-directory-existence esta desactivada."
            elif [[ $language == "ENG" ]]; then
                echo -e "[\e[31m#\e[0m] $msg_revision_eng The autonetplan-directory-existence configuration is disabled."
            fi
        else
            if [[ $language == "ESP" ]]; then
                echo -e "[\e[31m#\e[0m] $msg_revision No se ha encontrado la linea autonetplan-directory-existence."
            elif [[ $language == "ENG" ]]; then
                echo -e "[\e[31m#\e[0m] $msg_revision_eng The autonetplan-directory-existence line was not found."
            fi
        fi
    elif [[ "$opcion_aes" == "false" ]]; then
        # Aviso de configuracion deshabilitada
        if [[ $language == "ESP" ]]; then
            echo -e "[\e[31m#\e[0m] $msg_revision La configuracion autonetplan-enable-search esta desactivada."
        elif [[ $language == "ENG" ]]; then
            echo -e "[\e[31m#\e[0m] $msg_revision_eng The autonetplan-enable-search setting is disabled."
        fi
    fi
fi