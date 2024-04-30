# Por Andres Abadias
# Programa de busqueda de ficheros para autonetplan

# Variables del programa
program_config=/etc/autonetplan/autonetplan.conf

# Variables de mensajeria
## Variables de color
red_msg="[\e[31m#\e[0m]"
yellow_msg="[\e[33m#\e[0m]"
green_msg="[\e[32m#\e[0m]"
white_msg="[#]"
## Variables de mensajes
msg_revision="[Revision de datos]:"

# Iniciacion del programa
echo "$green_msg $msg_revision Revision de integridad de datos del programa autonetplan en curso."
# Revisar si el fichero de configuracion existe
if [[ -f $program_config ]]; then
    # Enviar mensaje de existencia de fichero de configuracion
    echo "$white_msg $msg_revision En ejecucion"
    # Revisar si la opcion principal esta habilitada
    opcion_aes=$(grep "^autonetplan-enable-search" "$program_config" | cut -d "=" -f2)
    # Comprobar si la opcion esta establecida en true o false
    if [[ "$opcion_aes" == "true" ]]; then
        # Revisar si alguna de las otras dos opciones esta activa
        opcion_afe=$(grep "^autonetplan-file-existence" "$program_config" | cut -d "=" -f2)
        # Comprobar si la opcion esta establecida en true o false
        if [[ "$opcion_afe" == "true" ]]; then
            # Revisa los ficheros y su integridad

            # Codigo

        elif [[ "$opcion_afe" == "false" ]]; then
            # Aviso de configuracion deshabilitada
            echo -e "$red_msg $msg_revision La configuracion autonetplan-file-existence esta desactivada."
        else
            echo -e "$red_msg $msg_revision No se ha encontrado la linea autonetplan-file-existence."
        fi
    elif [[ "$opcion_aes" == "false" ]]; then
        # Aviso de configuracion deshabilitada
        echo -e "$red_msg $msg_revision La configuracion autonetplan-enable-search esta desactivada."
    fi
fi