# Por Andres Abadias

#Copyright [2024] [Andres Abadias]
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
network_dir="/etc/netplan/00-installer-config.yaml"
work_dir="/usr/local/sbin"
program_files="/usr/local/sbin/auto-netplan"
INSTALL_DIR="/usr/local/sbin"
# Fichero autonetplan del directorio autoneconf renombrado como autonetplan
program_config="/etc/autonetplan/autonetplan.conf"
# Ruta de programa revision integridad de autonetplan
integrity_program=/usr/local/sbin/auto-netplan/program-files/dir-file-search.sh

# Proxima actualizacion -> este "help" ubicar en ruta /usr/local/sbin/autonetplan/autonetplan.help
# Al llamar, este sera expuesto con cat (ruta)
function aune-help(){
    # Comprobar que el fichero existe
    if [[ -f "$program_files/program-files/autonetplan.help" ]]; then
        # Mostrar fichero con posibilidad de subir o bajar en la lectura
        sudo less $program_files/program-files/autonetplan.help
    else
    # Aviso de problema (no crear fichero - tiempo innecesario)
        echo -e "[\e[31m#\e[0m] Error, fichero de soporte no encontrado"
    fi
}

function aune-manual(){
    # Comprobar que el fichero existe
    if [[ -f "$program_files/program-files/autonetplan.man" ]]; then
        # Mostrar fichero con posibilidad de subir o bajar en la lectura
        sudo less $program_files/program-files/autonetplan.man
    else
    # Aviso de problema (no crear fichero - tiempo innecesario)
        echo -e "[\e[31m#\e[0m] Error, manual no encontrado"
    fi
}

function aune-remove(){
    # Revisar en el fichero de configuracion si la opcion autonetplan-prevent-purge-on-mistake es true o false
    # Buscar la opcion autonetplan-prevent-purge-on-mistake en el archivo de configuracion
    opcion=$(grep "^autonetplan-prevent-purge-on-mistake" "$program_config" | cut -d "=" -f2)
    # Comprobar si la opcion esta establecida en true o false
    if [ "$opcion" == "true" ]; then
        # Accion si la opcion es true
        echo "La opcion autonetplan-prevent-purge-on-mistake esta configurada como true."
    elif [ "$opcion" == "false" ]; then
        # Accion si la opcion es false
        echo "La opcion autonetplan-prevent-purge-on-mistake esta configurada como false."
        echo -e "[\e[31m#\e[0m] Autonetplan esta siendo desinstalado..."
        # Funcion desinstalar programa
        sudo rm -rf $program_files
        sudo rm -f $INSTALL_DIR/autonetplan
        sudo rm -rf $program_config
        # Revisar si quedan ficheros del programa
        if [[ -d $program_files || -f $INSTALL_DIR/autonetplan || -d $program_config ]]; then
            # Borrar forzosamente todos los ficheros o directorios
            sudo rm -rf $program_files
            sudo rm -f $INSTALL_DIR/autonetplan
            sudo rm -rf $program_config
        else
            echo -e "[\e[32m#\e[0m] Programa desinstalado correctamente."
        fi
    else
        echo -e "[\e[33m!\e[0m] La opcion autonetplan-formatted-on-call no esta definida correctamente en el archivo de configuracion."
    fi
}


function aune-integrity(){
    # Revisar que el fichero de configuracion exista
    if [[ -f $program_config ]]; then
        echo "[#] Revisando el fichero de configuracion..."
        # Revisar dentro del fichero si la funcion de lectura de programas esta activada
        opcion_aes=$(grep "^autonetplan-enable-search" "$program_config" | cut -d "=" -f2)
        # Comprobar si la opcion esta establecida en true o false
        if [[ "$opcion_aes" == "true" ]]; then
            # Mensaje de depuración
            echo "[#] La opción autonetplan-enable-search está habilitada."
            # Ejecutar fichero de lectura integridad del programa
            echo "[#] Ejecutando el script de búsqueda de archivos..."
            sudo bash "$integrity_program"
        elif [[ "$opcion_aes" == "false" ]]; then
            echo -e "[\e[31m#\e[0m] La función autonetplan-enable-search está desactivada y no se puede continuar con la operación."
        fi
    else
        # Avisar de la inexistencia del fichero
        echo -e "[\e[31m#\e[0m] El fichero de configuración no se ha encontrado."
    fi
}

function aune-backup(){
    # Variables
    network_name="00-installer-config.yaml"
    network_dired="/etc/netplan"
    backup_dir="autonetplan-backups"

    # Comprobar existencia de ruta de backups
    echo "[#] Revisando existencia de ruta $program_files/$backup_dir"
    if [[ ! -d "$program_files/$backup_dir" ]]; then
        echo -e "[\e[31m#\e[0m] Ruta no existente, creando ruta..."
        # Crear ruta de copia de seguridad
        sudo mkdir -p "$program_files/$backup_dir"
    fi

    # Si existe previamente la ruta...
    if [[ -d "$program_files/$backup_dir" ]]; then
        echo -e "[\e[32m#\e[0m] Ruta $program_files/$backup_dir existente"
        # Generar un número aleatorio para el nombre del archivo de copia de seguridad
        digited=$(($RANDOM%100))
        echo "[#] Copiando fichero $network_name..."
        # Almacenar la copia de seguridad con un valor aleatorio para identificarla correctamente
        sudo cp "$network_dired/$network_name" "$program_files/$backup_dir/$network_name-$digited.bk"
        echo -e "[\e[32m#\e[0m] Copia de seguridad completada."
        echo "[#] La copia de seguridad se ha guardado como $network_name-$digited.bk" "en la ruta" "$program_files/$backup_dir"
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
            echo -e "[\e[33m#\e[0m] Configuración de red por configuracion automatica..."
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
EOF
}

function comment_line_dhcp_true(){
    # Configuracion de red para ip dinamica (dhcp4: true)
    # Usa sed para comentar la línea que contiene "gateway4: y addresses"
    sudo sed -i '/^\s*addresses:/ s/^/# /' "$network_dir"
    sudo sed -i '/^\s*gateway4:/ s/^/# /' "$network_dir"
}

function comment_line_gateway4(){
    # Configuracion de red para servidores
    # Usa sed para comentar la línea que contiene "gateway4:"
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
    # Revisar en configuracion si autonetplan-formatted-on-call es true o false
    opcionafoc=$(grep "^autonetplan-formatted-on-call" "$program_config" | cut -d "=" -f2)
    # Comprobar si la opcion esta establecida en true o false
    if [[ "$opcionafoc" == "true" ]]; then
        # Se limpia el contenido de la variable $network_dir
        > "$network_dir"
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
    # Continuacion de programa
    if [[ $2 == "-m" || $2 == "--manual" ]]; then
        sudo nano "$network_dir"
    elif [[ $2 == "-a" || $2 == "--automatic" ]]; then
        # Configuracion automatica
        if [[ $3 == "-iface" || $3 == "--interface" ]]; then
            # Preguntar por interfaz de red a usar
            read -p "Ingrese la interfaz de red a usar: " iface
            # Continuacion de programa
            if [[ $4 == "-f" || $3 == "--fluid" ]]; then
                # Configuracion de red por DHCP
                echo "Configuración de red seleccionada con conexion por DHCP"
                # DHCP4 ==  true >> Aplicar cambios en configuracion de red
                ipfigured=true
                # Aplicar directamente la configuracion (posteriormente, comentar las lineas gateway, ip, etc)
                aune-networked
                # Aplicar configuracion de red
                sudo netplan apply
                # Comentar secciones (al ser ip dinamica)
                comment_line_dhcp_true
                # Aplicar cambios al programa netplan meidante la llamada a la funcion netplanapply
                netplanapply           
            elif [[ $4 == "-s" || $3 == "--static" ]]; then
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
                aune-networked
                #► Aviso por gateway4
                echo -e "[\e[33m#\e[0m] Es pobile que si no se ha seleccionado gateway4 como (-lnkd), muestre un aviso de problema en la configuracion, no obstante, no debera preocuparse, pues todo se resuelve automaticamente."
                # Aplicar configuracion de red
                netplanapply
                if [[ $5 == "-lnkd" || $7 == "--linkeddoor" ]]; then
                    # Preguntar por puerta de enlace
                    read -p "Ingrese una puerta de enlace: " linkeddoor
                    # Llamar a funcion aune-networked
                    # Sustituir valores
                    aune-networked
                    # Aplicar red
                    netplanapply
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
else
    # Mensaje por error de valores
    echo -e "[\e[31m#\e[0m] Error de valores ingresados: '-h', '-r', '-b', '-l', '-m' '-x'."
    # Error por ingreso de valores erroneos
    exit 1
fi

# [Boceto Configuracion posterior]
# Tras la primera configuracion, el valor $8 servira para confirmar si se quiere configurar mas de una tarjeta de red
# read -p "¿Desea agregar una tarjeta de red nueva? [y/n]: " netcrd
# while [[ $netcrd == "-y" || $netcrd == "--yes" ]]; do
#   Configuracion
#   Preguntar nuevamente por configurar una nueva tarjeta de red
#   read -p "¿Desea agregar una tarjeta de red nueva? [y/n]: " netcrd
# done
# No se desea configurar otra tarjeta de red (amarillo)
# echo -e "[\e[33m!\e[0m] No se desea configurar otra tarjeta de red"