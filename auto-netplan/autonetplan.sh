# Por Andres Rulsan Abadias Otal

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

# [[Avisos del programa a tener en cuenta]]
# Si es de color rojo el aviso = importante revisar
#   [\e[31m#\e[0m] >> # rojo
# Si es de color amarillo el aviso = sugerencia o no obligatorio
#   [\e[33m!\e[0m] >> ! amarillo
# Si es de color verde el aviso = todo realizado correctamente
#   [\e[32m#\e[0m] >> # verde

# Declaracion variable directorio de configuracion netplan
# Ruta de programa
work_dir="/usr/local/sbin"
# Ruta de ficheros del programa
program_files="/usr/local/sbin/auto-netplan"
# Fichero autonetplan del directorio autoneconf renombrado como autonetplan
program_config="/etc/autonetplan/autonetplan.conf"
# Revisar dentro del fichero la ruta de configuracion de red
# Problemas ocn almacenamiento, salida en blanco
network_dir=$(grep "^autonetplan-netplan-route-config" "$program_config" | cut -d "=" -f2)
# Ruta de programa revision integridad de autonetplan
integrity_program=/usr/local/sbin/auto-netplan/program-files/dir-file-search.sh
# Ruta de ultima version
current_version=$(cat $program_files/program-files/version)
# Idioma del programa
language=$(cat $program_files/program-files/language.lg)
# Auto actualizaciones del programa
auto_update=$(grep "^autonetplan-update-program" "$program_config" | cut -d "=" -f2)

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

# Funcion de auto actualizacion
function aune-autoupdate(){
    # Indicar que todavia se esta desarrollando esta seccion del codigo
    echo "Esta seccion del codigo no funciona correctamente, se esta trabajando en una solucion."

    if [[ $auto_update == "true" ]]; then
        if [[ $language == "ESP" ]]; then
            echo "[#] La opcion 'autonetplan-update-program' esta establecida como 'true'."
        elif [[ $language == "ENG" ]]; then
            echo "[#] The 'autonetplan-update-program' option is set to 'true'."
        else
            echo -e "[\e[31m#\e[0m] L46U4G3 N0T R3615T343D."
        fi
        # Revisar actualizacion y comparar
        # Obtener la ultima version desde GitHub sobre el programa
        latest_release=$(curl -s https://api.github.com/repos/Nisamov/autonetplan/releases | jq .[0].name)
        # Obtener ultima version
        # Extraer el numero de version del nombre del release
        latest_version=$(echo "$latest_release" | sed -n 's/.*v\([0-9]\+\.[0-9]\+\.[0-9]\+\).*/\1/p')

        # Verificar si hay una nueva version disponible
        if [[ "$latest_version" != "$current_version" ]]; then
            if [[ $language == "ESP" ]]; then
                echo "[#] ¡Nueva version disponible! Version actual: $current_version, Última version: $latest_version"
            elif [[ $language == "ENG" ]]; then
                echo "[#] New version available! Current version: $current_version, Last version: $latest_version"
            else
                echo "[#] No se ha registrado un idioma"
                language-registration
            fi
            # Actualizar directamente
            # COdigo de actualizacion
        else
            if [[ $language == "ESP" ]]; then
                echo "[#] Tu programa ya esta actualizado. Version actual: $current_version"
            elif [[ $language == "ENG" ]]; then
                echo "[#] Your program is already updated. Current version: $current_version"
            else
                echo "[#] No se ha registrado un idioma"
                language-registration
            fi
        fi
    elif [[ $auto_update == "false" ]]; then
        if [[ $language == "ESP" ]]; then
        echo "[#] La opcion 'autonetplan-update-program' esta establecida como 'false'."
        elif [[ $language == "ENG" ]]; then
            echo "[#] The 'autonetplan-update-program' option is set to 'false'."
        else
            echo "[#] No se ha registrado un idioma"
            language-registration
        fi
    else
        echo -e "[\e[31m#\e[0m] La opcion 'autonetplan-update-program' no se ha detectado."
    fi
}

# Llamada a la funcion aune-autoupdate
aune-autoupdate

# Funcion de ayuda
# Al llamar, este sera expuesto con cat (ruta)
function aune-help(){
    # Comprobar que el fichero existe
    if [[ -f "$program_files/program-files/autonetplan.help" ]]; then
        # Mostrar fichero con posibilidad de subir o bajar en la lectura
        sudo less $program_files/program-files/autonetplan.help
    else
    # Aviso de problema (no crear fichero - tiempo innecesario)
        if [[ $language == "ESP" ]]; then
            echo -e "[\e[31m#\e[0m] Error, fichero de soporte no encontrado."
        elif [[ $language == "ENG" ]]; then
            echo -e "[\e[31m#\e[0m] Error, support file not found".
        else
            echo "[#] Idioma no registrado / Laguage not registered."
            language-registration
        fi
    fi
}

function aune-manual(){
    # Comprobar que el fichero existe
    if [[ -f "$program_files/program-files/autonetplan.man" ]]; then
        # Mostrar fichero con posibilidad de subir o bajar en la lectura
        sudo less $program_files/program-files/autonetplan.man
    else
    # Aviso de problema (no crear fichero - tiempo innecesario)
        if [[ $language == "ESP" ]]; then
            echo -e "[\e[31m#\e[0m] Error, manual no encontrado."
        elif [[ $language == "ENG" ]]; then
            echo -e "[\e[31m#\e[0m] Error, manual not found."
        else
            echo "[#] Idioma no registrado / Laguage not registered."
            language-registration
        fi
    fi
}

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
            language-registration
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
            language-registration
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
                echo -e "[\e[32m#\e[0m] Programa desinstalado correctamente / Program successfully uninstalled."
            fi
        fi
    else
        echo -e "[\e[33m!\e[0m] La opcion autonetplan-formatted-on-call no esta definida correctamente en el archivo de configuracion."
    fi
}


function aune-integrity(){
    # Revisar que el fichero de configuracion exista
    if [[ -f $program_config ]]; then
        if [[ $language == "ESP" ]]; then
            echo "[#] Revisando el fichero de configuracion..."
        elif [[ $language == "ENG" ]]; then
            echo "[#] Reviewing the configuration file..."
        else
            echo "[#] Idioma no registrado / Laguage not registered."
            language-registration
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
                language-registration
            fi
            sudo bash "$integrity_program"
        elif [[ "$opcion_aes" == "false" ]]; then
            if [[ $language == "ESP" ]]; then
                echo -e "[\e[31m#\e[0m] La funcion autonetplan-enable-search esta desactivada y no se puede continuar con la operacion."
            elif [[ $language == "ENG" ]]; then
                echo -e "[\e[31m#\e[0m] The autonetplan-enable-search function is disabled and the operation cannot be continued."
            else
                echo "[#] Idioma no registrado / Laguage not registered."
                language-registration
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
            language-registration
        fi
    fi
}

function new-network-card(){
    # Ingresar en un bucle while con valores otorgados desde el interior del mismo
    while [[ $addnwntcd == "s" || $addnwntcd == "S" ]]; do
        # Inicio de configuracion
        if [[ $language == "ESP" ]]; then
            echo "[#] Configurando otra tarjeta de red..."
            # Configuracion para la terjeta de red (configuracion por ingreso mediante "read -p")
            read -p "[#] Ingrese la interfaz de red a configurar: " ntinterface
            read -p "[#] Elije el modo de conexion [ s (Estatica) / d (Dinamica) ]: " dhcp4configured
        elif [[ $language == "ENG" ]]; then
            echo "[#] Configuring another network card..."
            read -p "[#] Enter the network interface to be configured: " ntinterface
            read -p "[#] Select the connection mode [ s (Static) / d (Dynamic) ]: " dhcp4configured
        else
            echo "[#] Idioma no registrado / Laguage not registered."
            language-registration
        fi

        if [[ $dhcp4configured == "s" || $dhcp4configured == "y" ]]; then
            if [[ $language == "ESP" ]]; then
                echo "[#] Se ha establecido la opcion 'configuracion estatica'."
            elif [[ $language == "ENG" ]]; then
                echo "[#] The 'static configuration' option has been set."
            else
                echo "[#] Idioma no registrado / Laguage not registered."
                language-registration
            fi
            # Declaracion de variable de dhcp4 para la tarjeta de red
            dhcp4netwconfig="no"
        elif [[ $dhcp4configured == "d" || $dhcp4configured == "q" ]]; then
            if [[ $language == "ESP" ]]; then
                echo "[#] Se ha establecido la opcion 'configuracion dinamica'."
            elif [[ $language == "ENG" ]]; then
                echo "[#] The 'dynamic configuration' option has been set."
            else
                echo "[#] Idioma no registrado / Laguage not registered."
                language-registration
            fi
            # Declaracion de variable de dhcp4 para la tarjeta de red
            dhcp4netwconfig="yes"
        fi
        # Apicar la configuracion de red sin aviso (evitar molestar)
        sudo netplan apply
        # Si dhcp4 se ha configurado como true, no continuar
        # Si dhcp4 se ha configurado como no, continuar
        if [[ $dhcp4netwconfig == "no" ]]; then
            # Preguntar por direccion IP y Mascara de red
            if [[ $language == "ESP" ]]; then
                read -p "[#] Ingrese la direccion IP a agregar a la tarjeta de red: " ipattachedseccondary
                read -p "[#] Ingrese la mascara de red a agregar a la tarjeta de red: " ntmskattachedseccondary
            elif [[ $language == "ENG" ]]; then
                 read -p "[#] Enter the IP address to add to the network card: " ipattachedseccondary
                 read -p "[#] Enter the network mask to add to the network card: " ntmskattachedseccondary
            else
                echo "[#] Idioma no registrado / Laguage not registered."
                language-registration
            fi
            # Aplicar red sin hacer saber al usuario
            sudo netplan apply
        else
            # Avisar que no se aplicara ip ni mascara de red debido a la configuracion establecida para esta tarjeta de red
            if [[ $language == "ESP" ]]; then
                echo "[#] No se aplicara direccion ip manual ni mascara de red 'dhcp4=no'."
            elif [[ $language == "ENG" ]]; then
                echo "[#] No manual ip address or netmask 'dhcp4=no' will be applied."
            else
                echo "[#] Idioma no registrado / Laguage not registered."
                language-registration
            fi
            # Comentar configuracion IP y Mascara de red
            # [REVISAR] - Buscar forma de unicamente comentar las lineas de la mascara de red a configurar (evitar configurar el resto por error)
            # Aplicar red sin hacer saber al usuario
            sudo netplan apply
        fi
        # Preguntar por gateway4:
        if [[ $language == "ESP" ]]; then
            read -p "[#] Ingrese una puerta de enlace para la tarjeta de red: " gatewayattachedseccondary
        elif [[ $language == "ENG" ]]; then
            read -p "[#] Enter a gateway for the network card: " gatewayattachedseccondary
        else
            echo "[#] Idioma no registrado / Laguage not registered."
            language-registration
        fi
        # Aplicar cambios sin hacer saber al usuario
        sudo netplan apply
        # Preguntar por configurar otra tarjeta de red
        read -p "¿Deseas configurar una nueva tarjeta de red? [s/n]: " addnwntcd
    done

    if [[ $addnwntcd == "n" || $addnwntcd == "N" ]]; then
        echo "[#] Se ha cancelado la creacion de una nueva tarjeta de red."

    elif [[ $addnwntcd == "" ]]; then
        echo "[#] Se ha dejado el campo vacio."
    fi
}

function aune-backup(){
    # Variables
    backup_dir="autonetplan-backups"

    # Comprobar existencia de ruta de backups
    echo "[#] Revisando existencia de ruta $program_files/program-files/$backup_dir"
    if [[ ! -d "$program_files/program-files/$backup_dir" ]]; then
        echo -e "[\e[31m#\e[0m] Ruta no existente, creando ruta..."
        # Crear ruta de copia de seguridad
        sudo mkdir -p "$program_files/program-files/$backup_dir"
    fi

    # Si existe previamente la ruta...
    if [[ -d "$program_files/program-files/$backup_dir" ]]; then
        echo -e "[\e[32m#\e[0m] Ruta $program_files/program-files/$backup_dir existente"
        # Generar un numero aleatorio para el nombre del archivo de copia de seguridad
        digited=$(($RANDOM%100))
        echo "[#] Copiando fichero $network_dir..."
        # Almacenar la copia de seguridad con un valor aleatorio para identificarla correctamente
        sudo cp "$network_dir" "$program_files/program-files/$backup_dir/network_backup_"$digited".bk"
        echo -e "[\e[32m#\e[0m] Copia de seguridad completada."
        echo "[#] La copia de seguridad se ha guardado como network_backup_"$digited".bk" "en la ruta" "$program_files/program-files/$backup_dir"
    else
        echo -e "[\e[31m#\e[0m] Ha ocurrido un error inesperado."
    fi
}

function netplanapply(){
    # Preguntar si aplicar cambios de red
    read -p "¿Desea aplicar los cambios antes de continuar? [s/n]: " netwapply
    if [[ $netwapply == "s" ]]; then
        sudo netplan apply
    elif [[ $netwapply == "n" ]]; then
        echo -e "[\e[31m#\e[0m] Se ha denegado la aplicacion de cambios."
    else
        # Mensaje rojo - referencia
        echo -e "[\e[31m#\e[0m] Se ha introducido un valor no registrado."
        # Mensaje verde - referencia
        echo -e "[\e[32m#\e[0m] Se han aplicado los cambios por seguridad."
        sudo netplan apply
    fi
}

function aune-networked(){
    # Configuracion de red por autonetplan
            echo -e "[\e[33m#\e[0m] Configuracion de red por configuracion automatica..."
            sudo cat <<EOF > "$network_dir"
# Editado con autonetplan
network:
  version: 2
  renderer: networkd
  ethernets:
    $iface:
      dhcp4: $ipfigured
      addresses: [$ipconfigure/$masked]
      gateway4: $linkeddoor
# Otras tarjetas de red
EOF
}

function aune-networked-secondary(){
    # Configuracion tajeta secundaria de red
            echo -e "[\e[33m#\e[0m] Configuracion de red secundaria"
            sudo cat <<EOF >> "$network_dir"
    $ntinterface:
      dhcp4: $dhcp4netwconfig
      addresses: [$ipattachedseccondary/$ntmskattachedseccondary]
      gateway4: $gatewayattachedseccondary
EOF
}

function comment_line_dhcp_true(){
    # Configuracion unica para la primera tarjeta de red configurada
    # Configuracion de red para ip dinamica (dhcp4: true)
    # Usa sed para comentar la linea que contiene "gateway4: y addresses"
    sudo sed -i '/^\s*addresses:/ s/^/# /' "$network_dir"
    sudo sed -i '/^\s*gateway4:/ s/^/# /' "$network_dir"
}

function comment_line_gateway4(){
    # Configuracion unica para la primera tarjeta de red configurada
    # Configuracion de red para servidores
    # Usa sed para comentar la linea que contiene "gateway4:"
    sudo sed -i '/^\s*gateway4:/ s/^/# /' "$network_dir"
}
function show_net_configuration(){
    # Mostrar configuracion de red, usar tras aplicar configuraciones de red
    # Preguntar si mostrar configuracion
    read -p "[#] ¿Desea revisar los cambios de red aplicados? [s/n]: " netapplication
    if [[ $netapplication == "s" ]]; then
        # Mostrar ip a
        echo "[#] Se ha solicitado la revision de red, mostrando..."
        sudo ip a
    else
        # Se ha cancelado la vista previa
        echo "[#] Se ha cancelado la vista de red"
    fi
}

function show_net_file_configuration_enabled(){
    # Mostrar el fichero de red que se configurara
    echo "El fichero de configuracion de red que se configurara a continuacion es el siguiente: $network_dir"
    echo "Para cambiar la ruta de configuracion, reestablezca su ruta en el fichero $program_config"
}

function change_program_language(){
    # Configuracion de cambio de idioma
    if [[ $language == "ESP" ]]; then
        read -p "¿Que idioma quiere establecer? [esp/eng]: " languageremodel
        if [[ $languageremodel == "esp" ]]; then
        sudo cat <<EOF > "$program_files/program-files/language.lg"
ESP
EOF
        echo "[#] Idioma cambiado a Español"
        elif [[ $languageremodel == "eng" ]]; then
        sudo cat <<EOF > "$program_files/program-files/language.lg"
ENG
EOF
        echo "[#] Language changed to English"
        fi
    elif [[ $language == "ENG" ]]; then
        read -p "What language do you want to set? [esp/eng]: " languageremodel
        if [[ $languageremodel == "esp" ]]; then
        sudo cat <<EOF > "$program_files/program-files/language.lg"
ESP
EOF
        echo "[#] Idioma cambiado a Español"
        elif [[ $languageremodel == "eng" ]]; then
        sudo cat <<EOF > "$program_files/program-files/language.lg"
ENG
EOF
        echo "[#] Language changed to English"
        fi
    else
        echo -e "[\e[31m#\e[0m] L46U4G3 N0T R3615T343D."
    fi
}

if [[ $1 == "-h" || $1 == "--help" ]]; then
    # Mostrar ayuda de la ruta raiz, tras haber instalado el programa
    # Llamada de funcion ayuda
        aune-help
elif [[ $1 == "-i" || $1 == "--integrity" ]]; then
    # Llamada de funcion aune-integrity
        aune-integrity
elif [[ $1 == "-m" || $1 == "--manual" ]]; then
    # Llamada de funcion aune-manual
        aune-manual
elif [[ $1 == "-r" || $1 == "--remove" ]]; then
    # Llamada de funcion aune-remove
        aune-remove
elif [[ $1 == "-b" || $1 == "--backup" ]]; then
    # Creacion de copia de seguridad de configuracion de red
    # Llamada a funcion aune-backup
        aune-backup
elif [[ $1 == "-u" || $1 == "--update" ]]; then
    # Informar de configuracion no estable
    echo "[#] Esta opcion del programa no se ha desarrollado correctamente."
    read -p "[#] ¿Desea continuar? [s/n]: " updatecontinue
    if [[ $updatecontinue == "s" ]]; then
        # Llamar a funcion aune-autoupdate
        aune-autoupdate
    elif [[ $updatecontinue == "n" ]]; then
        # Si se cancela la operacion
        echo "[#] Se ha cancelado la actualizacion"
        exit 1
    else
        # Si se ingresa un valor no valido
        echo "[#] Ingreso de valores no registrados, cancelando..."
        exit 1
    fi

elif [[ $1 == "-v" || $1 == "--version" ]]; then
    # Mostrar version del programa
    echo "$current_version"
elif [[ $1 == "-l" || $1 == "--license" ]]; then
    # Lectura de fichero de licencia
        sudo less "$program_files/LICENSE.txt"
    # Continuacion con el programa
elif [[ $1 == "-x" || $1 == "--execute" ]]; then
    # Revisar en configuracion si autonetplan-automate-update es true o false
    opcionaau=$(grep "^autonetplan-automate-update" "$program_config" | cut -d "=" -f2)
    # Si es true - realizar descarga de paquetes
    if [[ "$opcionaau" == "true" ]]; then
        # Se descargar paquetes
        echo "[#] La configuracion autonetplan-automate-update esta configurada como true."
        echo "[#] Descargando paquetes..."
        sudo apt update
    elif [[ "$opcionaau" == "false" ]]; then
        # No se descargan paquetes
        echo "[#] La opcion autonetplan-automate-update esta configurada como false."
    else
        echo -e "[\e[31m#\e[0m] No se ha detectado ninguna configuracion con el ID autonetplan-automate-update."
    fi
    # Continuacion de programa
    if [[ $2 == "-m" || $2 == "--manual" ]]; then
        sudo nano "$network_dir"
    elif [[ $2 == "-a" || $2 == "--automatic" ]]; then
        # Configuracion automatica
        # Revisar en configuracion si autonetplan-formatted-on-call es true o false
        opcionafoc=$(grep "^autonetplan-formatted-on-call" "$program_config" | cut -d "=" -f2)
        # Comprobar si la opcion esta establecida en true o false
        if [[ "$opcionafoc" == "true" ]]; then
            # Se limpia el contenido de la variable $network_dir
            sudo > "$network_dir"
            # Aplicar cambios al programa netplan sin llamar a la funcion netplanapply
            sudo netplan apply
            # Mensaje de aviso - limpieza de configuracion exitosa
            echo -e "[#] Fichero de configuracion de red reestablecido"
        elif [[ "$opcionafoc" == "false" ]]; then
            # No se hace nada, continuando el programa
            # Se previene formatear el contenido del fichero de red
            echo "[#] La opcion autonetplan-formatted-on-call esta configurada como false."
        else
            echo -e "[\e[31m#\e[0m] No se ha detectado ninguna configuracion con el ID autonetplan-formatted-on-call."
        fi
        if [[ $3 == "-iface" || $3 == "--interface" ]]; then
            # Preguntar por interfaz de red a usar
            read -p "Ingrese la interfaz de red a usar: " iface
            # Continuacion de programa
            if [[ $4 == "-f" || $3 == "--fluid" ]]; then
                # Configuracion de red por DHCP
                echo "Configuracion de red seleccionada con conexion por DHCP"
                # DHCP4 ==  true >> Aplicar cambios en configuracion de red
                ipfigured=true
                # Aplicar directamente la configuracion (posteriormente, comentar las lineas gateway, ip, etc)
                sudo aune-networked
                # Aplicar configuracion de red
                sudo netplan apply
                # Comentar secciones (al ser ip dinamica)
                comment_line_dhcp_true
                # Aplicar cambios al programa netplan meidante la llamada a la funcion netplanapply
                netplanapply           
            elif [[ $4 == "-s" || $4 == "--static" ]]; then
                # Configuracion de red por ip estatica
                echo -e "[\e[33m#\e[0m] La configuracion de red esta establecida de forma estatica"
                # Continuacion de programa
                # Preguntar por ip a almacenar
                read -p "Ingrese la direccion IP a usar: " ipconfigure
                # Preugntar por mascara de red a agregar
                read -p "Ingrese la mascara de red a agregar: " masked
                # Esablecer ipfigured como no >> ip estatica
                ipfigured=no
                # Llamar a funcion aune-networked
                # Sustituir valores
                sudo aune-networked
                # Aviso por gateway4
                echo -e "[\e[33m#\e[0m] Es posbile que si no se ha seleccionado gateway4 como (-lnkd), muestre un aviso de problema en la configuracion, no obstante, no debera preocuparse, pues todo se resuelve automaticamente."
                # Aplicar configuracion de red sin avisar al usuario
                sudo netplan apply
                if [[ $5 == "-lnkd" || $5 == "--linkeddoor" ]]; then
                    # Preguntar por puerta de enlace
                    read -p "Ingrese una puerta de enlace: " linkeddoor
                    # Llamar a funcion aune-networked
                    # Sustituir valores
                    sudo aune-networked
                    # Aplicar red sin avisar al usuario
                    sudo netplan apply
                    # Seccion no reconocida por el programa, revision y ajuste de codigo
                    if [[ $6 == "-ntcd" || $6 == "--networkcard" ]]; then
                        # Llamar a la funcion new-network-card
                        new-network-card
                        # Configuracion para otra tarjeta de red (solo de ser necesario)
                        # Aplicar configuarion sin avisar al usuario
                        sudo netplan apply
                    fi
                else
                    # Mensaje por error de valores
                    echo -e "[\e[33m!\e[0m] No se ha ingresado una puerta de enlace: '-lnkd'."
                    # LLamar a funcion comment_line_gateway4 por saltarse -lnkd
                    comment_line_gateway4
                    # Aplicar red
                    netplanapply
                fi
                # Preguntar si mostrar configuracion de red
                # Llamar a la funcion show_net_configuration
                show_net_configuration
                # Realizar copia de seguridad si en el fichero de configuracion esta indicado como true
                # Revisar en configuracion si autonetplan-automate-update es true o false
                opcionaab=$(grep "^autonetplan-automate-backup" "$program_config" | cut -d "=" -f2)
                # Si es true - realizar copia de seguridad
                if [[ "$opcionaab" == "true" ]]; then
                    # Llamar a la funcion aune-backup
                    echo "[#] La configuracion autonetplan-automate-backup esta configurada como true."
                    aune-backup
                elif [[ "$opcionaab" == "false" ]]; then
                    # No se descargan paquetes
                    echo "[#] La opcion autonetplan-automate-backup esta configurada como false."
                else
                    echo -e "[\e[31m#\e[0m] No se ha detectado ninguna configuracion con el ID autonetplan-automate-backup."
                fi
            else
                # Mensaje por error de valores
                echo -e "[\e[31m#\e[0m] Error de valores ingresados: '-f' o '-s'."
                # Error por ingreso de valores erroneos
                exit 1
            fi
            # Ya sea ip estatica / ip dinamica, si pone en valor 5 = "-ntcd", se aplicara una nueva tarjeta de red
            if [[ $5 == "-ntcd" || $5 == "--networkcard" ]]; then
                    # Agregar mas configuracion para otras tarjetas de red
                    # Preguntar por otra tarjeta de red
                    read -p "¿Deseas configurar una nueva tarjeta de red? [s/n]: " addnwntcd
                    # Llamar a funcion new-network-card
                    new-network-card
                    # Guardar y aplicar cambios sin avisar al usuario
                    sudo netplan apply
                    # Prueba de manejo de valores
                    echo "[#] SUPUESTAMENTE LA FUNCION 'new-network-card' SE HA EJECUTADO"
            fi
        else
            # Mensaje por error de valores
            echo -e "[\e[31m#\e[0m] Error de valores ingresados: '-iface' o '--interface'."
            # Error por ingreso de valores erroneos
            exit 1
        fi
    else
        # Mensaje por error de valores
        echo -e "[\e[31m#\e[0m] Error de valores ingresados: '-m' o '-a'."
        # Error por ingreso de valores erroneos
        exit 1
    fi
# A partir de aqui, se llaman a las opciones con mas de 3 caracteres
elif [[ $1 == "-ntf" || $1 == "--netfileenabled" ]]; then
    # Mostrar fichero de configuracion activo - el cual se configurara si procedemos con el programa
        show_net_file_configuration_enabled
elif [[ $1 == "-clg" || $1 == "--changelanguage" ]]; then
    # Llamar a funcion de cambiar idioma
        change_program_language
#elif [[ $1 == "-" || $1 == "" ]]; then
else
    # Mensaje por error de valores
    echo -e "[\e[31m#\e[0m] Error de valores ingresados: '-h','-r', '-b', '-l', '-m' '-x', '-ntf'."
    # Error por ingreso de valores erroneos
    exit 1
fi