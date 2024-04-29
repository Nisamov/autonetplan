# Modelo en desarrollo
# Este codigo es la correcion de autonetplan.sh debido a fallos catastroficos en el programa
# Por Andres Abadias

# Declaracion variable directorio de configuracion netplan
network_dir="/etc/netplan/00-installer-config.yaml"
work_dir="/usr/local/sbin"
program_files="/usr/local/sbin/auto-netplan"
INSTALL_DIR="/usr/local/sbin"
# Fichero autonetplan del directorio autoneconf renombrado como autonetplan
program_config="/etc/autonetplan/autonetplan.conf"

# Proxima actualizacion -> este "help" ubicar en ruta /usr/local/sbin/auto-netplan/autonetplan.help
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

function aune-backup(){
    # Variables
    network_name=00-installer-config.yaml
    network_dired="/etc/netplan"
    # Funcion guardar copia de seguridad con numero progresivo para evitar reemplazar ficheros
    # Comprobar exitencia de ruta de backups
    echo "[#] Revisando existencia de ruta $program_files/program-files/autonetplan-backups"

    while [[ ! -d $program_files/program-files/autonetplan-backups ]]; do
        echo -e "[\e[31m#\e[0m] Ruta no existente, creando ruta..."
        # Crear ruta de copia de seguridad
        sudo mkdir "$program_files/program-files/autonetplan-backups"
    done
    # Si existe previamente la ruta...
    if [[ -d $program_files/program-files/autonetplan-backups ]]; then
        echo -e "[\e[32m#\e[0m] Ruta $program_files/program-files/autonetplan-backups existente"
        # Digitos random simplificados
        digited=$(($RANDOM%100))
        echo "[#] Copiando fichero $network_name..."
        # Almacenamos la copia de seguridad con un valor aleatorio para identificar correctamente la copia de seguridad
        sudo cp "$network_dired/$network_name" "$program_files/program-files/$network_name-$digited.bk"
        echo -e "[\e[32m#\e[0m] Copia de seguridad completada."
        echo "[#] La copia de seguridad se ha guardado como $network_name-$digited.bk"
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

comment_line_dhcp_true() {
    # Configuracion de red para ip dinamica (dhcp4: true)
    # Usa sed para comentar la línea que contiene "gateway4: y addresses"
    sudo sed -i '/^\s*addresses:/ s/^/# /' "$network_dir"
    sudo sed -i '/^\s*gateway4:/ s/^/# /' "$network_dir"
}

comment_line_gateway4() {
    # Configuracion de red para servidores
    # Usa sed para comentar la línea que contiene "gateway4:"
    sudo sed -i '/^\s*gateway4:/ s/^/# /' "$network_dir"
}


# Si es de color rojo el aviso = importante revisar
#   [\e[31m#\e[0m] >> # rojo
# Si es de color amarillo el aviso = sugerencia o no obligatorio
#   [\e[33m!!\e[0m] >> !! amarillo
# Si es de color verde el aviso = todo realizado correctamente

if [[ $1 == "-h" || $1 == "--help" ]]; then
    # Mostrar ayuda de la ruta raiz, tras haber instalado el programa
    # Llamada de funcion ayuda
        aune-help
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
    # Revisar en configuracion si autonetplan-formatted-on-call es true o false
    opcion=$(grep "^autonetplan-formatted-on-call" "$program_config" | cut -d "=" -f2)
    # Comprobar si la opcion esta establecida en true o false
    if [ "$opcion" == "true" ]; then
        # Se previene formatear el contenido del fichero de red
        # No se hace nada, continuando el programa
        echo "La opcion autonetplan-formatted-on-call esta configurada como true."
    elif [ "$opcion" == "false" ]; then
        # Se limpia el contenido de la variable $network_dir
        > "$network_dir"
        # Aplicar cambios al programa netplan meidante la llamada a la funcion netplanapply
        netplanapply
        # Mensaje de aviso - limpieza de configuracion exitosa
        echo -e "[\e[32m#\e[0m] Fichero de configuracion reestablecido"
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
                #¿ Aplicar directamente la configuracion (posteriormente, comentar las lineas gateway, ip, etc)
                aune-networked
                # Comentar secciones (al ser ip dinamica)
                comment_line_dhcp_true
                # Aplicar cambios al programa netplan meidante la llamada a la funcion netplanapply
                netplanapply           
            elif [[ $4 == "-s" || $3 == "--static" ]]; then
                # Configuracion de red por ip estatica
                echo -e "[\e[33m#\e[0m] La configuracion de red esta establecida de forma estatica"
                # Continuacion de programa
                if [[ $5 == "-ip" || $5 == "--ipconfigure" ]]; then
                    # Preguntar por ip a almacenar
                    read -p "Ingrese la direccion IP a usar: " ipconfigure
                    if [[ $6 == "-ntmk" || $6 == "--netmask" ]]; then
                        # Preugntar por mascara de red a agregar
                        read -p "Ingrese la mascara de red a agregar: " masked
                        if [[ $7 == "-lnkd" || $7 == "--linkeddoor" ]]; then
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
                    else
                        # Mensaje por error de valores
                        echo -e "[\e[31m#\e[0m] Error de valores ingresados: '-ntmk'."
                        # Aplicar cambios:
                            netplanapply
                        
                        # Error por ingreso de valores erroneos
                        exit 1
                    fi
                else
                    # Mensaje por error de valores
                    echo -e "[\e[31m#\e[0m] Error de valores ingresados: '-ip'."
                    # Error por ingreso de valores erroneos
                    exit 1
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