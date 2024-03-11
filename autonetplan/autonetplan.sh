#!/bin/bash
# Programa autonetplan
# Este programa permite configurar la red de tu equipo de manera automatica, evitando problemas de aplicacion, espacios o tabuladores
# Licencia Apache2.0

# Declaracion variable directorio de configuracion netplan
network_dir=/etc/netplan/01-network-manager-all.yml
# Declaracion variable ruta de programa

function aune-help(){
    echo "Soporte AutoNetplan"
    echo ""
    echo "Principales valores '$I':"
    echo "  -h | --help :: Mostrar ayuda de la ruta raiz, tras haber instalado el programa"
    echo "  -v | --version :: Mostrar version del programa"
    echo "  -r | --remove :: Desinstalar programa"
    echo "  -l | --license :: Mostrar licencia del programa"
    echo "  -b | --backup :: Creacion de copia de seguridad de configuracion de red"
    echo "  -x | --execute :: Continuacion con el programa"
    echo ""
    echo "Valores segunda categoría '$II'"
    echo "  -m | --manual :: Configuracion de red manual"
    echo "  -a | --automatic :: Configuracion de red automatica"
    echo ""
    echo "Valores tercera categoria '$III'"
    echo "  -f | --fluid :: Configuracion DHCP (red fluida)"
    echo "  -s | --static :: Configuracion fija (red estatica)"
    # ...Mas contenido proximamente - (Boceto en help.md)
}

function aune-remove(){
    # Funcion desinstalar programa
    sudo rm -f /usr/local/bin/autonetplan*
    sudo rm -rf /etc/auto-netplan/
}

case $1 in
    -h | --help)
    # Mostrar ayuda de la ruta raiz, tras haber instalado el programa
    # Llamada de funcion ayuda
        aune-help
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
    -l | --license)
    #Licencia
    ;;
    -x |--execute)
    # Continuacion de programa
    echo "Continuacion de programa"
    ;;
esac