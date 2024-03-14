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
    -x |--execute)
    # Continuacion de programa
    # Llamada funcion programa
    ;;
esac