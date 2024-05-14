# Por Andres Abadias
# Programa de busqueda de ficheros para autonetplan

# Variables del programa
program_config=/etc/autonetplan/autonetplan.conf

## Variables de mensajes
msg_revision="[Revision de datos]:"

#red_msg="[\e[31m#\e[0m]"
#yellow_msg="[\e[33m#\e[0m]"
#green_msg="[\e[32m#\e[0m]"

# Iniciacion del programa
echo -e "[\e[32m#\e[0m] $msg_revision Revision de integridad de datos del programa autonetplan en curso."
# Revisar si el fichero de configuracion existe
if [[ -f $program_config ]]; then
    # Enviar mensaje de existencia de fichero de configuracion
    echo "[#] $msg_revision En ejecucion"
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
                echo -e "[\e[32m#\e[0m] El fichero $opcion_fecf existe"
            else
            # Si el fichero no existe
                echo -e "[\e[31m#\e[0m] No se ha encontrado $opcion_fecf"
            fi
            # Busca fichero de programa
            opcion_feaf=$(grep "^file-existence-autonetplansh-file" "$program_config" | cut -d "=" -f2)
            # Si el fichero existe
            if [[ -f $opcion_feaf ]]; then
                echo -e "[\e[32m#\e[0m] El fichero $opcion_feaf existe"
            else
            # Si el fichero no existe
                echo -e "[\e[31m#\e[0m] No se ha encontrado $opcion_feaf"
            fi
            # Busca fichero de licencia
            opcion_felf=$(grep "^file-existence-license-file" "$program_config" | cut -d "=" -f2)
            # Si el fichero existe
            if [[ -f $opcion_felf ]]; then
                echo -e "[\e[32m#\e[0m] El fichero $opcion_felf existe"
            else
            # Si el fichero no existe
                echo -e "[\e[31m#\e[0m] No se ha encontrado $opcion_felf"
            fi
            # Busca el fcihero de version
            opcion_fevf=$(grep "^file-existence-version-file" "$program_config" | cut -d "=" -f2)
            # Si el fichero existe
            if [[ -f $opcion_fevf ]]; then
                echo -e "[\e[32m#\e[0m] El fichero $opcion_fecf existe"
            else
            # Si el fichero no existe
                echo -e "[\e[31m#\e[0m] No se ha encontrado $opcion_fevf"
            fi
            # Busca el fcihero de idioma
            opcion_felaf=$(grep "^file-existence-laguage-file" "$program_config" | cut -d "=" -f2)
            # Si el fichero existe
            if [[ -f $opcion_felaf ]]; then
                echo -e "[\e[32m#\e[0m] El fichero $opcion_felaf existe"
            else
            # Si el fichero no existe
                echo -e "[\e[31m#\e[0m] No se ha encontrado $opcion_felaf"
            fi
        elif [[ "$opcion_afe" == "false" ]]; then
            # Aviso de configuracion deshabilitada
            echo -e "[\e[31m#\e[0m] $msg_revision La configuracion autonetplan-file-existence esta desactivada."
        else
            echo -e "[\e[31m#\e[0m] $msg_revision No se ha encontrado la linea autonetplan-file-existence."
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
                echo -e "[\e[32m#\e[0m] El directorio $opcion_decd existe"
            else
                # Si no existe
                echo -e "[\e[31m#\e[0m] No se ha encontrado $opcion_decd"
            fi
            # Buscar directorio de ficheros del programa
            opcion_depfd=$(grep "^dir-existence-program-files-dir" "$program_config" | cut -d "=" -f2)
            if [[ -d $opcion_depfd ]]; then
                # Si el directorio existe
                echo -e "[\e[32m#\e[0m] El directorio $opcion_depfd existe"
            else
                # Si no existe
                echo -e "[\e[31m#\e[0m] No se ha encontrado $opcion_depfd"
            fi
        elif [[ "$opcion_ade" == "false" ]]; then
            # Aviso de configuracion deshabilitada
            echo -e "[\e[31m#\e[0m] $msg_revision La configuracion autonetplan-directory-existence esta desactivada."
        else
            echo -e "[\e[31m#\e[0m] $msg_revision No se ha encontrado la linea autonetplan-directory-existence."
        fi
    elif [[ "$opcion_aes" == "false" ]]; then
        # Aviso de configuracion deshabilitada
        echo -e "[\e[31m#\e[0m] $msg_revision La configuracion autonetplan-enable-search esta desactivada."
    fi
fi