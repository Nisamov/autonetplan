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

            # Codigo

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

            # Codigo

        elif [[ "$opcion_ade" == "false" ]]; then
            # Aviso de configuracion deshabilitada
            echo -e "[\e[31m#\e[0m] $msg_revision La configuracion autonetplan-directory-existence esta desactivada."
        else
            echo -e "[\e[31m#\e[0m] $msg_revision No se ha encontrado la linea autonetplan-directory-existence."
        fi

        # Opcion 3 - Rutas Manuales (Own-General-Existence)
        opcion_oge=$(grep "^own-general-existence" "$program_config" | cut -d "=" -f2)
        # Comprobar si la opcion esta establecida en true o false
        if [[ "$opcion_oge" == "true" ]]; then
            # Revisa las rutas indicadas

            # Codigo

        elif [[ "$opcion_oge" == "false" ]]; then
            # Aviso de configuracion deshabilitada
            echo -e "[\e[31m#\e[0m] $msg_revision La configuracion own-general-existence esta desactivada."
        else
            echo -e "[\e[31m#\e[0m] $msg_revision No se ha encontrado la linea own-general-existence."
        fi
    elif [[ "$opcion_aes" == "false" ]]; then
        # Aviso de configuracion deshabilitada
        echo -e "[\e[31m#\e[0m] $msg_revision La configuracion autonetplan-enable-search esta desactivada."
    fi
fi