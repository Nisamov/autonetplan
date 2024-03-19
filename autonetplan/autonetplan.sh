#!/bin/bash
# Programa autonetplan
# Este programa permite configurar la red de tu equipo de manera automatica, evitando problemas de aplicacion, espacios o tabuladores
# Licencia Apache2.0

# Declaracion variable directorio de configuracion netplan
network_dir="/etc/netplan/00-installer-config.yml"

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
}

function aune-remove(){
    # Funcion desinstalar programa
    sudo rm -f /usr/local/sbin/autonetplan
}

function aune-backup(){
    # Funcion guardar copia de seguridad con numero progresivo para evitar reemplazar ficheros
    local backup_number=0
    local backup_file
    echo "[#] Copiando fichero 02-network-manager-all.yml..."
    sudo cp "$network_dir" "$network_dir.bk"
    echo "[#] Copia completada."
}

function aune-man-config(){
    # Configuracion manual netplan
    sudo nano "$network_dir"
}

if [[ $1 == "-h" || $1 == "--help" ]]; then
    # Mostrar ayuda de la ruta raiz, tras haber instalado el programa
    # Llamada de funcion ayuda
        aune-help
elif [[ $1 == "-r" || $1 == "--remove" ]]; then
    # Llamada de funcion aune-remove
        aune-remove
elif [[ $1 == "-b" || $1 == "--backup" ]]; then
    # Creacion de copia de seguridad de configuracion de red
    # Llamada a funcion aune-backup
        aune-backup
elif [[ $1 == "-l" || $1 == "--license" ]]; then
    # Lectura de fichero de licencia
        sudo less "$network_dir"
        echo "Licencia mostrada con programa 'less', pulse 'q' para salir del programa."
elif [[ $1 == "-x" || $1 == "--execute" ]]; then
    # Continuacion de programa
    if [[ $2 == "-m" || $2 == "--manual" ]]; then
        # Llamada a configuracion manual
        aune-man-config
    elif [[ $2 == "-a" || $2 == "--automatic" ]]; then
        # Configuracion automatica
        # Continuacion de programa
        if [[ $3 == "-f" || $3 == "--fluid" ]]; then
            # Configuracion de red por DHCP
            echo "Configuración de red por DHCP..."
            # Aquí puedes agregar la lógica para configurar la red por DHCP
            sudo cat <<EOF > "$network_dir"
network:
  version: 2
  renderer: networkd
  ethernets:
    eth0:  # Ejemplo, reemplaza eth0 con tu interfaz de red real
      dhcp4: yes
EOF
        elif [[ $3 == "-s" || $3 == "--static" ]]; then
            # Configuracion de red por ip estatica
            # Continuacion de programa
            if [[ $4 == "-iface" || $4 == "--interface" ]]; then
                # Ingreso interfaz deseada - almacenada en variable "iface"
                iface="$5"
                # Ingreso direccion ip deseada - almacenada en variable "ipconfigure"
                ipconfigure="$6"
                # Ingreso mascara subred y puerta de enlace - almacenada en variables "masked" y "linkeddoor"
                masked="$7"
                linkeddoor="$8"
                # Generar el archivo YAML de configuración
                sudo cat <<EOF > "$network_dir"
network:
  version: 2
  renderer: networkd
  ethernets:
    $iface:
      dhcp4: no
      addresses: [$ipconfigure/$masked]
      gateway4: $linkeddoor
EOF
                echo "Configuración estática de red generada en $network_dir"
            else
                # Mensaje por error de valores
                echo -e "[\e[31m#\e[0m] Error de valores ingresados: '-iface', valor ingresado: '$4'."
                # Error por ingreso de valores erroneos
                exit 1
            fi
        else
            # Mensaje por error de valores
            echo -e "[\e[31m#\e[0m] Error de valores ingresados: '-f' o '-s', valor ingresado: '$3'."
            # Error por ingreso de valores erroneos
            exit 1
        fi
    else
        # Mensaje por error de valores
        echo -e "[\e[31m#\e[0m] Error de valores ingresados: '-m' o '-a', valor ingresado: '$2'."
        # Error por ingreso de valores erroneos
        exit 1
    fi
else
    # Mensaje por error de valores
    echo -e "[\e[31m#\e[0m] Error de valores ingresados: '-h', '-r', '-b', '-l' o '-x', valor ingresado: '$1'."
    # Error por ingreso de valores erroneos
    exit 1
fi