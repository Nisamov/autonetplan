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
network_dir=$(grep "^autonetplan-netplan-route-config" "$program_config" | cut -d "=" -f2)
# Ruta de programa revision integridad de autonetplan
integrity_program="/usr/local/sbin/auto-netplan/program-files/dir-file-search.sh"
# Ruta de ultima version
current_version=$(cat $program_files/program-files/version)
# Idioma del programa
language=$(cat $program_files/program-files/language.lg)
# Auto actualizaciones del programa
auto_update=$(grep "^autonetplan-update-program" "$program_config" | cut -d "=" -f2)
# Programas bifurcados del codigo original
aune_bifurcation_route="/usr/local/sbin/auto-netplan/function"

function new-network-card(){
    # Ingresar en un bucle while con valores otorgados desde el interior del mismo
    while [[ $addnwntcd == "s" || $addnwntcd == "S" || $addnwntcd == "y" || $addnwntcd == "Y" ]]; do
        # Inicio de configuracion
        if [[ $language == "ESP" ]]; then
            echo "[#] Configurando otra tarjeta de red..."
            # Configuracion para la terjeta de red (configuracion por ingreso mediante "read -p")
            read -p "[?] Ingrese la interfaz de red a configurar: " ntinterface
            read -p "[?] Elije el modo de conexion [ s (Estatica) / d (Dinamica) ]: " dhcp4configured
        elif [[ $language == "ENG" ]]; then
            echo "[#] Configuring another network card..."
            read -p "[?] Enter the network interface to be configured: " ntinterface
            read -p "[?] Select the connection mode [ s (Static) / d (Dynamic) ]: " dhcp4configured
        else
            echo "[#] Idioma no registrado / Laguage not registered."
            sudo bash "$aune_bifurcation_route/language-registration.sh"
        fi

        if [[ $dhcp4configured == "s" || $dhcp4configured == "y" ]]; then
            if [[ $language == "ESP" ]]; then
                echo "[#] Se ha establecido la opcion 'configuracion estatica'."
            elif [[ $language == "ENG" ]]; then
                echo "[#] The 'static configuration' option has been set."
            else
                echo "[#] Idioma no registrado / Laguage not registered."
                sudo bash "$aune_bifurcation_route/language-registration.sh"
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
                sudo bash "$aune_bifurcation_route/language-registration.sh"
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
                read -p "[?] Ingrese la direccion IP a agregar a la tarjeta de red: " ipattachedseccondary
                read -p "[?] Ingrese la mascara de red a agregar a la tarjeta de red: " ntmskattachedseccondary
            elif [[ $language == "ENG" ]]; then
                 read -p "[?] Enter the IP address to add to the network card: " ipattachedseccondary
                 read -p "[?] Enter the network mask to add to the network card: " ntmskattachedseccondary
            else
                echo "[#] Idioma no registrado / Laguage not registered."
                sudo bash "$program_files/function/language-registration.sh"
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
                sudo bash "$program_files/function/language-registration.sh"
            fi
            # Comentar configuracion IP y Mascara de red
            # [REVISAR] - Buscar forma de unicamente comentar las lineas de la mascara de red a configurar (evitar configurar el resto por error)
            # Aplicar red sin hacer saber al usuario
            sudo netplan apply
        fi
        # Preguntar por gateway4:
        if [[ $language == "ESP" ]]; then
            read -p "[?] Ingrese una puerta de enlace para la tarjeta de red: " gatewayattachedseccondary
        elif [[ $language == "ENG" ]]; then
            read -p "[?] Enter a gateway for the network card: " gatewayattachedseccondary
        else
            echo "[#] Idioma no registrado / Laguage not registered."
            sudo bash "$aune_bifurcation_route/language-registration.sh"
        fi
        # Aplicar cambios sin hacer saber al usuario
        sudo netplan apply
        # Preguntar por configurar otra tarjeta de red
        if [[ $language == "ESP" ]]; then
            read -p "[?] ¿Deseas configurar una nueva tarjeta de red? [s/n]: " addnwntcd
        elif [[ $language == "ENG" ]]; then
             read -p "[?] Do you want to configure a new network card? [y/n]: " addnwntcd
        else
            echo "[#] Idioma no registrado / Laguage not registered."
            sudo bash "$aune_bifurcation_route/language-registration.sh"
        fi
    done
    if [[ $addnwntcd == "n" || $addnwntcd == "N" ]]; then
        if [[ $language == "ESP" ]]; then
            echo "[#] Se ha cancelado la creacion de una nueva tarjeta de red."
        elif [[ $language == "ENG" ]]; then
            echo "[#] The creation of a new network card has been cancelled."
        else
            echo "[#] The creation of a new network card has been cancelled."
        fi

    elif [[ $addnwntcd == "" ]]; then
        if [[ $language == "ESP" ]]; then
            echo "[#] Se ha dejado el campo vacio."
        elif [[ $language == "ENG" ]]; then
            echo "[#] The field has been left empty."
        else
            echo "[#] The field has been left empty."
        fi
    fi
}

function aune-backup(){
    # Variables
    backup_dir="autonetplan-backups"

    # Comprobar existencia de ruta de backups
    if [[ $language == "ESP" ]]; then
        echo "[#] Revisando existencia de ruta $program_files/program-files/$backup_dir."
    elif [[ $language == "ESP" ]]; then
        echo "[#] Checking existence of path $program_files/program-files/$backup_dir."
    else
        echo "[#] Checking existence of path $program_files/program-files/$backup_dir."
    fi

    if [[ ! -d "$program_files/program-files/$backup_dir" ]]; then
        if [[ $language == "ESP" ]]; then
            echo -e "[\e[31m#\e[0m] Ruta no existente, creando ruta..."
        elif [[ $language == "ENG" ]]; then
            echo -e "[\e[31m#\e[0m] Non existing route, creating route..."
        else
            echo -e "[\e[31m#\e[0m] Non existing route, creating route..."
        fi
        # Crear ruta de copia de seguridad
        sudo mkdir -p "$program_files/program-files/$backup_dir"
    fi

    # Si existe previamente la ruta...
    if [[ -d "$program_files/program-files/$backup_dir" ]]; then
        if [[ $language == "ESP" ]]; then
            echo -e "[\e[32m#\e[0m] Ruta $program_files/program-files/$backup_dir existente."
        elif [[ $language == "ENG" ]]; then
            echo -e "[\e[32m#\e[0m] Existing $program_files/program-files/$backup_dir path."
        else
            echo -e "[\e[32m#\e[0m] Existing $program_files/program-files/$backup_dir path."
        fi
        # Generar un numero aleatorio para el nombre del archivo de copia de seguridad
        digited=$(($RANDOM%100))
        if [[ $language == "ESP" ]]; then
            echo "[#] Copiando fichero $network_dir..."
        elif [[ $language == "ENG" ]]; then
            echo "[#] Copying $network_dir file..."
        else
            echo "[#] Copying $network_dir file..."
        fi
        # Almacenar la copia de seguridad con un valor aleatorio para identificarla correctamente
        sudo cp "$network_dir" "$program_files/program-files/$backup_dir/network_backup_$digited.bk"
        if [[ -f "$program_files/program-files/$backup_dir/network_backup_$digited.bk" ]]; then
            if [[ $language == "ESP" ]]; then
                echo -e "[\e[32m#\e[0m] Copia de seguridad completada."
                echo "[#] La copia de seguridad se ha guardado como network_backup_$digited.bk en la ruta $program_files/program-files/$backup_dir."
            elif [[ $language == "ENG" ]]; then
                echo -e "[\e[32m#\e[0m] Backup completed."
                echo "[#] The backup has been saved as network_backup_$digited.bk in the path $program_files/program-files/$backup_dir."
            else
                echo -e "[\e[32m#\e[0m] Backup completed."
                echo "[#] The backup has been saved as network_backup_$digited.bk in the path $program_files/program-files/$backup_dir."
            fi
        else
            if [[ $language == "ESP" ]]; then
                echo "[#] La copia de seguridad ha fallado, asegurate que has referenciado correctamente la ruta en el fichero de configuracion '/etc/autonetplan/autonetplan.conf'"
            elif [[ $language == "ENG" ]]; then
                echo "[#] The backup has failed, make sure you have correctly referenced the path in the configuration file '/etc/autonetplan/autonetplan.conf'."
            else
                echo "[#] The backup has failed, make sure you have correctly referenced the path in the configuration file '/etc/autonetplan/autonetplan.conf'."
            fi
        fi
    else
        if [[ $language == "ESP" ]]; then
            echo -e "[\e[31m#\e[0m] Ha ocurrido un error inesperado."
        elif [[ $language == "ENG" ]]; then
            echo -e "[\e[31m#\e[0m] An unexpected error has occurred."
        else
            echo -e "[\e[31m#\e[0m] An unexpected error has occurred."
        fi
    fi
}

function aune-networked(){
    # Configuracion de red por autonetplan
    if [[ $language == "ESP" ]]; then
        echo -e "[\e[33m#\e[0m] Configuracion de red por configuracion automatica..."
    elif [[ $language == "ENG" ]]; then
        echo -e "[\e[33m#\e[0m] Network configuration by automatic configuration..."
    else
        echo -e "[\e[33m#\e[0m] Network configuration by automatic configuration..."
    fi
    sudo bash -c "cat <<EOF > '$network_dir'
# Editado con autonetplan / Edited with autonetplan
network:
  version: 2
  renderer: networkd
  ethernets:
    $iface:
      dhcp4: $ipfigured
      addresses: [$ipconfigure/$masked]
      gateway4: $linkeddoor
# Otras tarjetas de red / Other network cards
EOF"
}

function aune-networked-secondary(){
    # Configuracion tajeta secundaria de red
        if [[ $language == "ESP" ]]; then
            echo -e "[\e[33m#\e[0m] Configuracion de red secundaria."
        elif [[ $language == "ESP" ]]; then
            echo -e "[\e[33m#\e[0m] Secondary network configuration."
        else
            echo -e "[\e[33m#\e[0m] Secondary network configuration."
        fi
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
    read -p "[?] ¿Desea revisar los cambios de red aplicados? [s/n]: " netapplication
    if [[ $netapplication == "s" ]]; then
        # Mostrar ip a
        if [[ $language == "ESP" ]]; then
            echo "[#] Se ha solicitado la revision de red, mostrando..."
        elif [[ $language == "ENG" ]]; then
            echo "[#] The network revision has been requested, showing..."
        else
            echo "[#] The network revision has been requested, showing..."
        fi
        sudo ip a
    else
        # Se ha cancelado la vista previa
        if [[ $language == "ESP" ]]; then
            echo "[#] Se ha cancelado la vista de red."
        elif [[ $language == "ENG" ]]; then
            echo "[#] Network view has been canceled."
        else
            echo "[#] Network view has been canceled."
        fi
    fi
}

function show_net_file_configuration_enabled(){
    # Mostrar el fichero de red que se configurara
    if [[ $language == "ESP" ]]; then
        echo "[#] El fichero de configuracion de red que se configurara a continuacion es el siguiente: $network_dir"
        echo "[#] Para cambiar la ruta de configuracion, reestablezca su ruta en el fichero $program_config"
    elif [[ $language == "ENG" ]]; then
        echo "[#] The network configuration file to be configured next is as follows: $network_dir"
        echo "[#] To change the configuration path, reestablish its path in the file $program_config"
    else
        echo "[#] The network configuration file to be configured next is as follows: $network_dir"
        echo "[#] To change the configuration path, reestablish its path in the file $program_config"
    fi
}

if [[ $1 == "-d" || $1 == "--debug" ]]; then
    echo -e "[\e[33mDEBUG\e[0m] network_dir=$network_dir"
    echo -e "[\e[33mDEBUG\e[0m] workdir=$work_dir"
    echo -e "[\e[33mDEBUG\e[0m] program_files=$program_files"
    echo -e "[\e[33mDEBUG\e[0m] program_config=$program_config"
    echo -e "[\e[33mDEBUG\e[0m] network_dir=$network_dir"
    echo -e "[\e[33mDEBUG\e[0m] integrity_program=$integrity_program"
    echo -e "[\e[33mDEBUG\e[0m] current_version=$current_version"
    echo -e "[\e[33mDEBUG\e[0m] language=$language"
    echo -e "[\e[33mDEBUG\e[0m] auto_update=$auto_update"
    echo -e "[\e[33mDEBUG\e[0m] aune_bifurcation_route=$aune_bifurcation_route"
    echo -e "[\e[33mDEBUG\e[0m] program_config=$program_config"

elif [[ $1 == "-h" || $1 == "--help" ]]; then
    if [[ $auto_update == "true" ]]; then
        sudo bash "$aune_bifurcation_route/auto-update.sh"
    fi
    # Mostrar ayuda de la ruta raiz, tras haber instalado el programa
    # Llamada de funcion ayuda
        sudo bash "$aune_bifurcation_route/help.sh"
elif [[ $1 == "-p" || $1 == "--ping" ]]; then
    # Comprobar que el software recibe la solicitud
    if [[ $language == "ESP" ]]; then
        echo "[#] Ping recibido, recepción estable."
    elif [[ $language == "ENG" ]]; then
        echo "[#] Ping received, stable reception."
    else
        echo "[#] Ping received, stable reception."
    fi
elif [[ $1 == "-i" || $1 == "--integrity" ]]; then
    if [[ $auto_update == "true" ]]; then
        sudo bash "$aune_bifurcation_route/auto-update.sh"
    fi
    # Llamada de funcion aune-integrity
        sudo bash "$aune_bifurcation_route/integrity.sh"
elif [[ $1 == "-m" || $1 == "--manual" ]]; then
    if [[ $auto_update == "true" ]]; then
        sudo bash "$aune_bifurcation_route/auto-update.sh"
    fi
    # Llamada de funcion aune-manual
        sudo bash "$aune_bifurcation_route/manual.sh"
elif [[ $1 == "-r" || $1 == "--remove" ]]; then
    # Llamada de funcion aune-remove
        sudo bash "$aune_bifurcation_route/uninstall.sh"
elif [[ $1 == "-b" || $1 == "--backup" ]]; then
    if [[ $auto_update == "true" ]]; then
        sudo bash "$aune_bifurcation_route/auto-update.sh"
    fi
    # Creacion de copia de seguridad de configuracion de red
    # Llamada a funcion aune-backup
        aune-backup
elif [[ $1 == "-u" || $1 == "--update" ]]; then
    # Informar de configuracion no estable
    # Llamar a programa auto-update
    sudo bash "$aune_bifurcation_route/auto-update.sh"

elif [[ $1 == "-v" || $1 == "--version" ]]; then
    if [[ $auto_update == "true" ]]; then
        sudo bash "$aune_bifurcation_route/auto-update.sh"
    fi
    # Mostrar version del programa
    echo "$current_version"
elif [[ $1 == "-l" || $1 == "--license" ]]; then
    if [[ $auto_update == "true" ]]; then
        sudo bash "$aune_bifurcation_route/auto-update.sh"
    fi
    # Lectura de fichero de licencia
        sudo less "$program_files/LICENSE.txt"
    # Continuacion con el programa
elif [[ $1 == "-x" || $1 == "--execute" ]]; then
    if [[ $auto_update == "true" ]]; then
        # Actualizar el software
        sudo bash "$aune_bifurcation_route/auto-update.sh"
    fi
    # Revisar en configuracion si autonetplan-automate-update es true o false
    # Actualizar paquetes
    opcionaau=$(grep "^autonetplan-automate-update" "$program_config" | cut -d "=" -f2)
    # Si es true - realizar descarga de paquetes
    if [[ "$opcionaau" == "true" ]]; then
        # Se descargar paquetes
        if [[ $language == "ESP" ]]; then
            echo "[#] La configuracion autonetplan-automate-update esta configurada como true."
            echo "[#] Descargando paquetes..."
        elif [[ $language == "ENG" ]]; then
            echo "[#] The autonetplan-automate-update configuration is set to true."
            echo "[#] Downloading packages..."
        else
            echo "[#] The autonetplan-automate-update configuration is set to true."
            echo "[#] Downloading packages..."
        fi
        sudo apt update
    elif [[ "$opcionaau" == "false" ]]; then
        # No se descargan paquetes
        if [[ $language == "ESP" ]]; then
            echo "[#] La opcion autonetplan-automate-update esta configurada como false."
        elif [[ $language == "ENG" ]]; then
            echo "[#] The autonetplan-automate-update option is set to false."
        else
            echo "[#] The autonetplan-automate-update option is set to false."
        fi
    else
        if [[ $language == "ESP" ]]; then
            echo -e "[\e[31m#\e[0m] No se ha detectado ninguna configuracion con el ID autonetplan-automate-update."
        elif [[ $language == "ENG" ]]; then
            echo -e "[\e[31m#\e[0m] No configuration with the autonetplan-automate-update ID has been detected."
        else
            echo -e "[\e[31m#\e[0m] No configuration with the autonetplan-automate-update ID has been detected."
        fi
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
            sudo sh -c "> $network_dir"
            # Aplicar cambios al programa netplan sin llamar a la funcion netplanapply
            sudo netplan apply
            # Mensaje de aviso - limpieza de configuracion exitosa
            if [[ $language == "ESP" ]]; then
                echo "[#] Fichero de configuracion de red reestablecido."
            elif [[ $language == "ENG" ]]; then
                echo "[#] Network configuration file reestablished."
            else
                echo "[#] Network configuration file reestablished."
            fi
        elif [[ "$opcionafoc" == "false" ]]; then
            # No se hace nada, continuando el programa
            # Se previene formatear el contenido del fichero de red
            if [[ $language == "ESP" ]]; then
                echo "[#] La opcion autonetplan-formatted-on-call esta configurada como false."
            elif [[ $language == "ENG" ]]; then
                echo "[#] The autonetplan-formatted-on-call option is set to false."
            else
                echo "[#] The autonetplan-formatted-on-call option is set to false."
            fi
        else
            if [[ $language == "ESP" ]]; then
                echo -e "[\e[31m#\e[0m] No se ha detectado ninguna configuracion con el ID autonetplan-formatted-on-call."
            elif [[ $language == "ENG" ]]; then
                echo -e "[\e[31m#\e[0m] No configuration with the ID autonetplan-formatted-on-call has been detected."
            else
                echo -e "[\e[31m#\e[0m] No configuration with the ID autonetplan-formatted-on-call has been detected."
            fi
        fi
        if [[ $3 == "-iface" || $3 == "--interface" ]]; then
            # Preguntar por interfaz de red a usar
            if [[ $language == "ESP" ]]; then
                read -p "[?] Ingrese la interfaz de red a usar: " iface
            elif [[ $language == "ENG" ]]; then
                read -p "[?] Enter the network interface to use: " iface
            else
                read -p "[?] Enter the network interface to use: " iface
            fi
            # Continuacion de programa
            if [[ $4 == "-f" || $3 == "--fluid" ]]; then
                # Configuracion de red por DHCP
                if [[ $language == "ESP" ]]; then
                    echo "[#] Configuracion de red seleccionada con conexion por DHCP."
                elif [[ $language == "ENG" ]]; then
                    echo "[#] Selected network configuration with connection by DHCP."
                else
                    echo "[#] Selected network configuration with connection by DHCP."
                fi
                # DHCP4 ==  true >> Aplicar cambios en configuracion de red
                ipfigured=true
                # Aplicar directamente la configuracion (posteriormente, comentar las lineas gateway, ip, etc)
                aune-networked
                # Aplicar configuracion de red
                sudo netplan apply
                # Comentar secciones (al ser ip dinamica)
                comment_line_dhcp_true
                # Aplicar cambios al programa netplan meidante la llamada a la funcion netplanapply
                sudo bash "$aune_bifurcation_route/netplanapply.sh"           
            elif [[ $4 == "-s" || $4 == "--static" ]]; then
                if [[ $language == "ESP" ]]; then
                    # Configuracion de red por ip estatica
                    echo -e "[\e[33m#\e[0m] La configuracion de red esta establecida de forma estatica."
                    # Continuacion de programa
                    # Preguntar por ip a almacenar
                    read -p "[?] Ingrese la direccion IP a usar: " ipconfigure
                    # Preugntar por mascara de red a agregar
                    read -p "[?] Ingrese la mascara de red a agregar: " masked
                elif [[ $language == "ENG" ]]; then
                    echo -e "[\e[33m#\e[0m] The network configuration is statically set."
                    read -p "[?] Enter the IP address to use: " ipconfigure
                    read -p "[?] Enter the netmask to add: " masked
                else
                    echo -e "[\e[33m#\e[0m] The network configuration is statically set."
                    read -p "[?] Enter the IP address to use: " ipconfigure
                    read -p "[?] Enter the netmask to add: " masked
                fi
                # Esablecer ipfigured como no >> ip estatica
                ipfigured=no
                # Llamar a funcion aune-networked
                # Sustituir valores
                aune-networked
                # Aviso por gateway4
                if [[ $language == "ESP" ]]; then
                    echo -e "[\e[33m#\e[0m] Es posbile que si no se ha seleccionado gateway4 como (-lnkd), muestre un aviso de problema en la configuracion, no obstante, no debera preocuparse, pues todo se resuelve automaticamente."
                elif [[ $language == "ENG" ]]; then
                    echo -e "[\e[33m#\e[0m] It is possible that if gateway4 has not been selected as (-lnkd), it may show a problem warning in the configuration, however, you should not worry, as everything is solved automatically."
                else
                    echo -e "[\e[33m#\e[0m] It is possible that if gateway4 has not been selected as (-lnkd), it may show a problem warning in the configuration, however, you should not worry, as everything is solved automatically."
                fi
                # Aplicar configuracion de red sin avisar al usuario
                sudo netplan apply
                if [[ $5 == "-lnkd" || $5 == "--linkeddoor" ]]; then
                    # Preguntar por puerta de enlace
                    if [[ $language == "ESP" ]]; then
                        read -p "[?] Ingrese una puerta de enlace: " linkeddoor
                    elif [[ $language == "ENG" ]]; then
                        read -p "[?] Enter a gateway: " linkeddoor
                    else
                        read -p "[?] Enter a gateway: " linkeddoor
                    fi
                    # Llamar a funcion aune-networked
                    # Sustituir valores
                    aune-networked
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
                    if [[ $language == "ESP" ]]; then
                        echo -e "[\e[33m!\e[0m] No se ha ingresado una puerta de enlace: '-lnkd'."
                    elif [[ $language == "ENG" ]]; then
                        echo -e "[\e[33m!\e[0m] No gateway has been entered: '-lnkd'."
                    else
                        echo -e "[\e[33m!\e[0m] No gateway has been entered: '-lnkd'."
                    fi
                    # LLamar a funcion comment_line_gateway4 por saltarse -lnkd
                    comment_line_gateway4
                    # Aplicar red
                    sudo bash "$aune_bifurcation_route/netplanapply.sh"
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
                    if [[ $language == "ESP" ]]; then
                        echo "[#] La configuracion autonetplan-automate-backup esta configurada como true."
                    elif [[ $language == "ENG" ]]; then
                        echo "[#] The autonetplan-automate-backup configuration is set to true."
                    else
                        echo "[#] The autonetplan-automate-backup configuration is set to true."
                    fi
                    aune-backup
                elif [[ "$opcionaab" == "false" ]]; then
                    # No se descargan paquetes
                    if [[ $language == "ESP" ]]; then
                        echo "[#] La opcion autonetplan-automate-backup esta configurada como false."
                    elif [[ $language == "ENG" ]]; then
                        echo "[#] The autonetplan-automate-backup option is set to false."
                    else
                        echo "[#] The autonetplan-automate-backup option is set to false."
                    fi
                else
                    if [[ $language == "ESP" ]]; then
                        echo -e "[\e[31m#\e[0m] No se ha detectado ninguna configuracion con el ID autonetplan-automate-backup."
                    elif [[ $language == "ENG" ]]; then
                        echo -e "[\e[31m#\e[0m] No configuration with the autonetplan-automate-backup ID has been detected."
                    else
                        echo -e "[\e[31m#\e[0m] No configuration with the autonetplan-automate-backup ID has been detected."
                    fi
                fi
            else
                # Mensaje por error de valores
                if [[ $language == "ESP" ]]; then
                    echo -e "[\e[31m#\e[0m] Error de valores ingresados: '-f' o '-s'."
                elif [[ $language == "ENG" ]]; then
                    echo -e "[\e[31m#\e[0m] Error of values entered: '-f' or '-s'."
                else
                    echo -e "[\e[31m#\e[0m] Error of values entered: '-f' or '-s'."
                fi
                # Error por ingreso de valores erroneos
                exit 1
            fi
            # Ya sea ip estatica / ip dinamica, si pone en valor 5 = "-ntcd", se aplicara una nueva tarjeta de red
            if [[ $5 == "-ntcd" || $5 == "--networkcard" ]]; then
                # Agregar mas configuracion para otras tarjetas de red
                # Preguntar por otra tarjeta de red
                if [[ $language == "ESP" ]]; then
                    read -p "[?] ¿Deseas configurar una nueva tarjeta de red? [s/n]: " addnwntcd
                elif [[ $language == "ENG" ]]; then
                    read -p "[?] Do you want to configure a new network card? [y/n]: " addnwntcd
                else
                    read -p "[?] Do you want to configure a new network card? [y/n]: " addnwntcd
                fi
                # Llamar a funcion new-network-card
                new-network-card
                # Guardar y aplicar cambios sin avisar al usuario
                sudo netplan apply
            fi
        else
            # Mensaje por error de valores
            if [[ $language == "ESP" ]]; then
                echo -e "[\e[31m#\e[0m] Error de valores ingresados: '-iface' o '--interface'."
            elif [[ $language == "ENG" ]]; then
                echo -e "[\e[31m#\e[0m] Error of values entered: '-iface' or '--interface'."
            else
                echo -e "[\e[31m#\e[0m] Error of values entered: '-iface' or '--interface'."
            fi
            # Error por ingreso de valores erroneos
            exit 1
        fi
    else
        # Mensaje por error de valores
        if [[ $language == "ESP" ]]; then
            echo -e "[\e[31m#\e[0m] Error de valores ingresados: '-m' o '-a'."
        elif [[ $language == "ENG" ]]; then
            echo -e "[\e[31m#\e[0m] Error of values entered: '-m' or '-a'."
        else
            echo -e "[\e[31m#\e[0m] Error of values entered: '-m' or '-a'."
        fi
        # Error por ingreso de valores erroneos
        exit 1
    fi
# A partir de aqui, se llaman a las opciones con mas de 3 caracteres
elif [[ $1 == "-ntf" || $1 == "--netfileenabled" ]]; then
    # Mostrar fichero de configuracion activo - el cual se configurara si procedemos con el programa
    show_net_file_configuration_enabled
elif [[ $1 == "-clg" || $1 == "--changelanguage" ]]; then
    # Llamar a funcion de cambiar idioma
    sudo bash "$aune_bifurcation_route/change-language.sh"
else
    # Mensaje por error de valores
    if [[ $language == "ESP" ]]; then
        echo -e "[\e[31m#\e[0m] Error de valores ingresados: '-d', '-h', '-p', '-u', '-v', '-i', '-r', '-b', '-l', '-m', '-x', '-ntf'."
    elif [[ $language == "ENG" ]]; then
        echo -e "[\e[31m#\e[0m] Error values entered: '-d', '-h', '-p', '-u', '-v', '-i', '-r', '-b', '-l', '-m', '-x', '-ntf'."
    else
        echo -e "[\e[31m#\e[0m] Error values entered: '-d', '-h', '-p', '-u', '-v', '-i', '-r', '-b', '-l', '-m', '-x', '-ntf'."
    fi
    # Error por ingreso de valores erroneos
    exit 1
fi