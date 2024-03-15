#!/bin/bash
# Programa autonetplan
# Este programa permite configurar la red de tu equipo de manera automatica, evitando problemas de aplicacion, espacios o tabuladores
# Licencia Apache2.0

# Declaracion variable directorio de configuracion netplan
network_dir=/etc/netplan/01-network-manager-all.yml
# Declaracion variable ruta de programa
PROGRAM_FILES="/usr/local/sbin/auto-netplan"
PROGRAM_INSTALL="/usr/local/sbin/"

function aune-help(){
    echo "Soporte AutoNetplan"
    echo ""
    echo "Principales valores '$.1':"
    echo "  -h | --help :: Mostrar ayuda de la ruta raiz, tras haber instalado el programa"
    echo "  -r | --remove :: Desinstalar programa"
    echo "  -l | --license :: Mostrar licencia del programa"
    echo "  -b | --backup :: Creacion de copia de seguridad de configuracion de red"
    echo "  -x | --execute :: Continuacion con el programa"
    echo ""
    echo "Valores segunda categoría '$.2'"
    echo "  -m | --manual :: Configuracion de red manual"
    echo "  -a | --automatic :: Configuracion de red automatica"
    echo ""
    echo "Valores tercera categoria '$.3'"
    echo "  -f | --fluid :: Configuracion DHCP (red fluida)"
    echo "  -s | --static :: Configuracion fija (red estatica)"
    # ...Mas contenido proximamente - (Boceto en help.md)
}

function aune-remove(){
    # Funcion desinstalar programa
    sudo rm -f /usr/local/sbin/autonetplan
    sudo rm -rf /usr/local/sbin/program-files/
}

function aune-backup(){
    # Funcion guardar copia de seguridad con numero progresivo para evitar reemplazar ficheros
    local backup_number=0
    local backup_file
    echo "[#] Copiando fichero 00-installer-config.yaml..."
    # Encuentra el último número utilizado en los archivos de respaldo
    while [[ -f "$PROGRAM_FILES/netplan-backups/00-installer-config-${backup_number}-*.yaml.bk" ]]; do
        ((backup_number++))
    done
    echo "[#] Copia completada."
    # Construye el nombre del archivo de respaldo con el siguiente número
    backup_file="$PROGRAM_FILES/netplan-backups/00-installer-config-${backup_number}-$(printf "%03d" "$backup_number").yaml.bk"
    # Realiza la copia de seguridad
    sudo cp /etc/netplan/00-installer-config.yaml "$backup_file."
    echo "[#] Copia de seguridad almacenada como $backup_file en $PROGRAM_FILES/netplan-backups."
}

function aune-man-config(){
    # Configuracion manual netplan
    sudo nano network_dir
}

function aune-full-config(){
    if [[ $2 == "-m" || $2 == "--manual"]]; then
            # Llamada a configuracion manual
            aune-man-config
            # Salida del programa
            exit 1
        elif [[ $2 == "-a" || $2 == "--automatic"]]; then
            # Configuracion automatica
            # Continuacion de programa
            if [[ $3 == "-f" || $3 == "--fluid" ]]; then
                # Configuracion de red por DHCP
            elif [[ $3 == "-s" || $3 == "--static" ]]; then
                # Configuracion de red por ip estatica
                # Continuacion de programa
                if [[ $4 == "-iface" || $4 == "--interface"]]; then
                    # Ingreso interfaz deseada - almacenada en variable "iface"
                    # Continuacion de programa
                    read -p "Ingrese la interfaz a trabajar: " iface
                    if [[ $5 == "-ip" || $5 == "--ipconfigure"]]; then
                        # Ingreso direccion ip deseada - almacenada en variable "ipconfigure"
                        # Continuacion de programa
                        # Direccion ip (ej: 192.168.10.165)
                        read -p "Ingrese la direccion ip a trabajar: " ipconfigure
                        if [[ $6 == "-ntmk" || $6 == "--netmask" ]]; then
                            # Ingreso mascara subred y puerta de enlace - almacenada en variables "masked" y "linkeddoor"
                            # Fin programa - continuacion de codigo
                            # Mascara subred (ej: /16)
                            read -p "Ingrese la mascara de subred: " masked
                            # Puerta de enlace (ej: 192.168.10.1)
                            read -p "Ingrese la puerta de enlace a trabajar: " linkeddoor
                        else
                            # Mensaje por error de valores
                            echo -e "[\e[31m#\e[0m] Error de valores ingresados: '-ntmk', valor ingresado: '$6'."
                            # Error por ingreso de valores erroneos
                            exit 0
                        fi
                    else
                        # Mensaje por error de valores
                        echo -e "[\e[31m#\e[0m] Error de valores ingresados: '-ip', valor ingresado: '$5'."
                        # Error por ingreso de valores erroneos
                        exit 0
                    fi
                else
                    # Mensaje por error de valores
                    echo -e "[\e[31m#\e[0m] Error de valores ingresados: '-iface', valor ingresado: '$4'."
                    # Error por ingreso de valores erroneos
                    exit 0
                fi
            else
                # Mensaje por error de valores
                echo -e "[\e[31m#\e[0m] Error de valores ingresados: '-f' o '-s', valor ingresado: '$3'."
                # Error por ingreso de valores erroneos
                exit 0
            fi
        else
            # Mensaje por error de valores
            echo -e "[\e[31m#\e[0m] Error de valores ingresados: '-m' o '-a', valor ingresado: '$2'."
            # Error por ingreso de valores erroneos
            exit 0
        fi
}

case $1 in
    -h | --help)
    # Mostrar ayuda de la ruta raiz, tras haber instalado el programa
    # Llamada de funcion ayuda
        aune-help
    ;;
    -r | --remove)
    # Llamada de funcion aune-remove
        aune-remove
    ;;
    -bk)
    # Creacion de copia de seguridad de configuracion de red
    # Llamada a funcion aune-backup
        aune-backup
    ;;
    -l | --license)
    # Lectura de fichero de licencia
        sudo less $PROGRAM_FILES/LICENSE.txt
    ;;
    -x | --execute)
    # Continuacion de programa
    # Llamada al programa completo
        aune-full-config
    ;;
esac

# Crear funcion de fichero con vairbles modificables, contenido ejecutado desde el siguiente codigo
# Programa sin terminar

# Con los valores almacenados, se solicita hacer una copia de seguridad del fichero de configuracion ip actual, para almacenarlo  como .bk en la misma ruta
read -p "¿Desea crear una copia de seguridad del fichero de configuracion red actual? (s/n): " ntwbk
# Si se deniega la copia, se procede con el programa
# Si se acepta, se guarda el fichero
if [[ $ntwbk == "s" ]]; then
    # Almacenar configuracion red actual como backup
    sudo cp $network_dir $network_dir.bk
elif [[ $ntwbk == "n" ]]; then
    # Se ha denegado la copia de seguridad
    echo -e "[\e[31m#\e[0m] Has rechazado la copia de seguridad, se procedera con el programa."
else
    echo -e "[\e[31m#\e[0m] Se ha ingresado un valor invalido ('$ntwbk'), se procede a omitir la copia de seguridad."
fi