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
        -h      / --help            >> Mostrar ayuda del programa
        -v      / --version         >> Mostrar version del programa
        -r      / --remove          >> Desinstalar el programa
        -bk     / --backup          >> Crear copia de seguridad de la configuracion actual
        -x      / --execute         >> Continuar con la ejecucion del programa
    $2:_
        -m      / --manual          >> Configuracion manual
        -a      / --automatic       >> Configuracion automatica
        -bkrt   / --backuproute     >> Direccion donde guardar la copia de seguridad (por defecto se guradar en /etc/auto-netplan/backups)
    $3:_
        -f      / --fluid           >> Configuracion DHCP (red fluida)
        -s      / --static          >> Configuracion fija (red estatica)
    $4:_
        -iface  / --interface       >> Inidcar posteriormente la interfaz a usar
    $5:_
        -ip     / --ipconfigure
    $6:_
        -ntmk   / --netmask

Exit Codes:
    exit 0 > Codigo de salida por introduccion de valor erroneo
    exit 1 > Codigo de salida por salida exitosa del programa
