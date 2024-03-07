Programa configuracion automatica > netplan

Clonar repositorio:
    instalar git:
        sudo apt install git
    clonar repositorio:
        git clone https://github.com/Nisamov/auto-netplan (ruta)
    ejecutar instalador:
        cd 7home/$USER/downloads
        cd auto-netplan
        sudo bash instalacion.sh

Llamar al programa:
    autonetplan.sh (introducir parametros)

Paramteros:
    $1:_
        -h / --help     >> Mostrar ayuda del programa
        -v / --version  >> Mostrar version del programa
        -r / --remove   >> Eliminar programa
        -x / --execute  >> Continuar con la ejecucion del programa
    $2:_
        -m / --manual   >> Configuracion manual
        -a / --automatic>> Configuracion automatica
    $3:_
        -f / --fluid    >> Configuracion DHCP (red fluida)
        -s / --static   >> Configuracion fija (red estatica)