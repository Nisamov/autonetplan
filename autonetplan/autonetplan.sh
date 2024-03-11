#!/bin/bash
# Programa autonetplan
# Este programa permite configurar la red de tu equipo de manera automatica, evitando problemas de aplicacion, espacios o tabuladores
# Licencia Apache2.0

# Declaracion variable directorio de configuracion netplan
network_dir=/etc/netplan/01-network-manager-all.yml
# Declaracion variable ruta de programa

function aune-remove(){
    # Funcion desinstalar programa
    sudo rm -rf /usr/local/bin/autonetplan/
    sudo rm -rf /etc/auto-netplan/
}

case $1 in
    -h | --help)
    # Mostrar ayuda de la ruta raiz, tras haber instalado el programa
        cat /etc/auto-netplan/xample/help.md
    ;;
    -v | --version)
    # Mostrar version del programa
        cat /etc/auto-netplan/version.md
    ;;
    -r | --remove)
    # Llamada de funcion aune-remove
        aune-remove
    ;;
    -bk)
    # Creacion de copia de seguridad de configuracion de red
    ;;
    -x)
    # Continuacion de programa
    ;;
esac