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
# Ruta de programa revision integridad de autonetplan
integrity_program="/usr/local/sbin/auto-netplan/program-files/dir-file-search.sh"
# Ruta de ultima version
current_version=$(cat "$program_files/program-files/version")
# Idioma del programa
language=$(cat "$program_files/program-files/language.lg")
# Programas bifurcados del codigo original
aune_bifurcation_route="/usr/local/sbin/auto-netplan/function"


# Variables almacenamiento de datos del fichero de configuracion

# Revisar dentro del fichero la ruta de configuracion de red
network_dir=$(grep "^autonetplan-netplan-route-config" "$program_config" | cut -d "=" -f2)
# Auto actualizaciones del programa
auto_update=$(grep "^autonetplan-update-program" "$program_config" | cut -d "=" -f2)
# IP a color
ip_colored=$(grep "^autonetplan-ip-colored" "$program_config" | cut -d "=" -f2)
# Actualizar paquetes
opcionaau=$(grep "^autonetplan-automate-update" "$program_config" | cut -d "=" -f2)
# Configuracion de schedule - tiempo configuracion de tareas automaticas
opcionacdt=$(grep "^autonetplan-cron-default-time" "$program_config" | cut -d "=" -f2)
# Revisar en configuracion si autonetplan-formatted-on-call es true o false
opcionafoc=$(grep "^autonetplan-formatted-on-call" "$program_config" | cut -d "=" -f2)
# Revisar en configuracion si autonetplan-automate-backup es true o false
opcionaab=$(grep "^autonetplan-automate-backup" "$program_config" | cut -d "=" -f2)

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
                echo -e "[\e[31m#\e[0m] La copia de seguridad ha fallado, asegurate que has referenciado correctamente la ruta en el fichero de configuracion '/etc/autonetplan/autonetplan.conf'"
            elif [[ $language == "ENG" ]]; then
                echo -e "[\e[31m#\e[0m] The backup has failed, make sure you have correctly referenced the path in the configuration file '/etc/autonetplan/autonetplan.conf'."
            else
                echo -e "[\e[31m#\e[0m] The backup has failed, make sure you have correctly referenced the path in the configuration file '/etc/autonetplan/autonetplan.conf'."
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
# Editado con AutoNetplan / Edited with AutoNetplan
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

function new-network-card(){
    if [[ $language == "ESP" ]]; then
        echo "[#] Configurando una nueva tarjeta de red."
        read -p "[?] Ingrese la interfaz de red a configurar: " nxtiface
        echo "[#] Se ha seleccionado a configurar la interfaz '$nxtiface' para la configuracion."
        # Se añade la linea al final del fichero de configuracion de red netplan
        sudo bash -c "cat <<EOF >> '$network_dir'
    $nxtiface:
EOF"
        while [[ $nxtipfigured != "s" && $nxtipfigured != "f" ]]; do
            read -p "[?] Ingrese el tipo de configuracion deseado [(Estatico) s / f (Dinamico)]: " nxtipfigured
        done
        if [[ $nxtipfigured == "s" ]]; then
            # IP Estatica
            nxtipfigureddb="no"
            # Agregar la configuracion estatica
            sudo bash -c "cat <<EOF >> '$network_dir'
      dhcp4: $nxtipfigureddb
EOF"
            # Se continua con las preguntas
            echo "[#] Se ha selccionado la configuracion estatica."
            read -p "[?] Ingrese la direccion IP a establecer: " ipconfigurenxt
            read -p "[?] Ingrese la mascara de red: " maskednxt
            # Agregar los parametros guardados al fichero
            sudo bash -c "cat <<EOF >> '$network_dir'
      addresses: [$ipconfigurenxt/$maskednxt]
EOF"
        else
            # IP Dinamica
            nxtipfigureddb="true"
            # Agregar la configuracion dinamica
            sudo bash -c "cat <<EOF >> '$network_dir'
      dhcp4: $nxtipfigureddb
EOF"
            echo "[#] Se ha selccionado la configuracion dinamica."
        fi
        read -p "[?] ¿Deseas agregar una puerta de enlace? [s/n]: " prtenlace
        if [[ $prtenlace == "s" ]]; then
            read -p "[?] Ingrese la puerta de enlace a agregar: " linkeddoornxt
            sudo bash -c "cat <<EOF >> '$network_dir'
      gateway4: $linkeddoornxt
EOF"
        else
            echo "[#] Se ha denegado el ingreso de la puerta de enlace."
        fi
        sudo sh -c "echo '# Siguiente tarjeta de red' >> '$network_dir'"
        # Aplicar cambios
        sudo netplan apply
    else
        echo "[#] Configuring a new network card."
        read -p "[?] Enter the network interface to be configured: " nxtiface
        echo "[#] You have selected to configure the interface '$nxtiface' for the configuration."
        sudo bash -c "cat <<EOF >> '$network_dir'
    $nxtiface:
EOF"
        while [[ $nxtipfigured != "s" && $nxtipfigured != "f" ]]; do
            read -p "[?] Enter the desired configuration type [(Static) s / f (Dynamic)]: " nxtipfigured
        done
        if [[ $nxtipfigured == "s" ]]; then
            nxtipfigureddb="no"
            sudo bash -c "cat <<EOF >> '$network_dir'
      dhcp4: $nxtipfigureddb
EOF"
            echo "[#] The static configuration has been selected."
            read -p "[?] Enter the IP address to be set: " ipconfigurenxt
            read -p "[?] Enter the network mask: " maskednxt
            sudo bash -c "cat <<EOF >> '$network_dir'
      addresses: [$ipconfigurenxt/$maskednxt]
EOF"
        else
            nxtipfigureddb="true"
            sudo bash -c "cat <<EOF >> '$network_dir'
      dhcp4: $nxtipfigureddb
EOF"
            echo "[#] The dynamic configuration has been selected."
        fi
        read -p "[?] Do you want to add a gateway? [y/n]: " prtenlace
        if [[ $prtenlace == "y" ]]; then
            read -p "[?] Enter the gateway to add: " linkeddoornxt
            sudo bash -c "cat <<EOF >> '$network_dir'
      gateway4: $linkeddoornxt
EOF"
        else
            echo "[#] Gateway login has been denied."
        fi
        sudo sh -c "echo '# Next netcard' >> '$network_dir'"
        # Aplicar cambios
        sudo netplan apply
    fi

    if [[ $language == "ESP" ]]; then
        read -p "[?] Desea añadir una nueva tarjeta de red? [s/n]: " newtarjred
        if [[ $newtarjred == "s" ]]; then
            # Volver a llamar a funcion
            new-network-card
        else
            echo "[#] No se agregara otra tarjeta de red."
        fi
    else
        read -p "[?] Do you want to add a new network card? [y/n]: " newtarjred
        if [[ $newtarjred == "s" ]]; then
            # Volver a llamar a funcion
            new-network-card
        else
            echo "[#] No additional network card will be added."
        fi
    fi
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
    if [[ $language == "ESP" ]]; then
        read -p "[?] ¿Desea revisar los cambios de red aplicados? [s/n]: " netapplication
    else
        read -p "[?] Do you want to review the applied network changes? [y/n]: " netapplication
    fi
    if [[ $netapplication == "s" || $netapplication == "y" ]]; then
        # Mostrar ip a
        if [[ $language == "ESP" ]]; then
            echo "[#] Se ha solicitado la revision de red, mostrando..."
        else
            echo "[#] The network revision has been requested, showing..."
        fi
        if [[ $ip_colored == "true" ]];then
            sudo ip -c a
        elif [[ $ip_colored == "false" ]];then
            sudo ip a
        else
            if [[ $language == "ESP" ]]; then
                echo -e "[\e[31m#\e[0m] No se ha detectado la configuracion 'autonetplan-ip-colored'."
            else
                echo -e "[\e[31m#\e[0m] No 'autonetplan-ip-colored' configuration was detected."
            fi
        fi
    else
        # Se ha cancelado la vista previa
        if [[ $language == "ESP" ]]; then
            echo "[#] Se ha cancelado la vista de red."
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
    echo -e "[\e[33mDEBUG\e[0m] formated_on_call=$opcionafoc"
    echo -e "[\e[33mDEBUG\e[0m] language=$language"
    echo -e "[\e[33mDEBUG\e[0m] auto_update=$auto_update"
    echo -e "[\e[33mDEBUG\e[0m] auto_apt_update=$opcionaau"
    echo -e "[\e[33mDEBUG\e[0m] aune_bifurcation_route=$aune_bifurcation_route"
    echo -e "[\e[33mDEBUG\e[0m] program_config=$program_config"
    echo -e "[\e[33mDEBUG\e[0m] colored_ip=$ip_colored"
    echo -e "[\e[33mDEBUG\e[0m] cron_time_conf=$opcionacdt"
    echo -e "[\e[33mDEBUG\e[0m] auto_backup=$opcionaab"

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
                # Aplicar configuracion de red
                sudo netplan apply        
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
                    # Aplicar configuracion de red
                    sudo netplan apply
                fi
                # Preguntar si mostrar configuracion de red
                # Llamar a la funcion show_net_configuration
                show_net_configuration
                # Realizar copia de seguridad si en el fichero de configuracion esta indicado como true
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
elif [[ $1 == "-excd" || $1 == "--exitcode" ]]; then
    # Llamar al script de revision de salida
    sudo bash "$aune_bifurcation_route/verify-exitcode.sh"
elif [[ $1 == "-s" || $1 == "--schedule" ]]; then
    # Programar acciones con cron
    # Opciones:
    # backup, update
    # Backup permitira realizar copias constantes cada x tiempo
    # Update realizara busquedas para actualizar el software cada x tiempo
    # Ejemplo de uso:
    # --schedule backup 2024-06-10 02:00
    # --schedule update 2024-06-10 02:00
    # Llamar al script de schedules - $2: opcion | $3: fecha | $4: hora
    sudo bash "$aune_bifurcation_route/schedule.sh" $2 $3 $4 $5 $6

elif [[ "$@" == "" ]]; then
    if [[ $language == "ESP" ]]; then
        echo -e "[\e[31m#\e[0m] No se ha ingresado ningun valor, ingrese uno de los siguientes:"
    elif [[ $language == "ENG" ]]; then
        echo -e "[\e[31m#\e[0m] No value has been entered, enter one of the following:"
    else
        echo -e "[\e[31m#\e[0m] No value has been entered, enter one of the following:"
    fi
    echo "-h     | --help "
    echo "-d     | --debug"
    echo "-p     | --ping"
    echo "-r     | --remove"
    echo "-l     | --license"
    echo "-b     | --backup"
    echo "-u     | --update "
    echo "-v     | --version"
    echo "-x     | --execute"
    echo "-m     | --manual"
    echo "-i     | --integrity"
    echo "-ntf   | --netfileenabled"
    echo "-clg   | --changelanguage"
    echo "-excd  | --exitocde"
    if [[ $language == "ESP" ]]; then
        echo "[#] Para mas informacion, usa el comando autonetplan -h."
    elif [[ $language == "ENG" ]]; then
        echo "[#] For more information, use the command autonetplan -h."
    else
        echo "[#] For more information, use the command autonetplan -h."
    fi
    exit 1
else
    # Mensaje por error de valores
    if [[ $language == "ESP" ]]; then
        echo -e "[\e[31m#\e[0m] Valor ingresado: $1 "
        echo -e "[\e[31m#\e[0m] El valor ingresado no es compatible con ninguno de los siguientes valores:"
        echo "'-d', '-h', '-p', '-u', '-v', '-i', '-r', '-b', '-l', '-m', '-x', '-ntf', '-excd'"
    elif [[ $language == "ENG" ]]; then
        echo -e "[\e[31m#\e[0m] Entered value: $1 "
        echo -e "[\e[31m#\e[0m] Entered value is not compatible with none of the following values:"
        echo "'-d', '-h', '-p', '-u', '-v', '-i', '-r', '-b', '-l', '-m', '-x', '-ntf', '-excd'"
    else
        echo -e "[\e[31m#\e[0m] Entered value: $1 "
        echo -e "[\e[31m#\e[0m] Entered value is not compatible with none of the following values:"
        echo "'-d', '-h', '-p', '-u', '-v', '-i', '-r', '-b', '-l', '-m', '-x', '-ntf', '-excd'"
    fi
    # Error por ingreso de valores erroneos
    exit 1
fi