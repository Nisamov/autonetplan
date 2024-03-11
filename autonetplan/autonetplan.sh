#!/bin/bash
# Programa autonetplan
# Este programa permite configurar la red de tu equipo de manera automatica, evitando problemas de aplicacion, espacios o tabuladores
# Licencia Apache2.0

# Declaracion variable directorio de configuracion netplan
network_dir=/etc/netplan/01-network-manager-all.yml
# Declaracion variable ruta de programa
PROGRAM_FILES="/usr/local/sbin/auto-netplan/"
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

# Declaracion inicio programa autonetplan
function netplan(){
    # Funcion autonetplan (no funcional por $1, $2, $3... sino por read -p)

    # ... codigo por rellenar

}

case $1 in
    -h | --help)
    # Mostrar ayuda de la ruta raiz, tras haber instalado el programa
    # Llamada de funcion ayuda
        aune-help
    ;;
    ;;
    -r | --remove)
    # Llamada de funcion aune-remove
        aune-remove
    ;;
    -bk)
    # Creacion de copia de seguridad de configuracion de red
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