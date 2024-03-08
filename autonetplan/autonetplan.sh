#!/bin/bash
# Programa autonetplan
# Este programa permite configurar la red de tu equipo de manera automatica, evitando problemas de aplicacion, espacios o tabuladores
# Licencia Apache2.0

# Ejemplo llamada al programa:
#La siguiente orden establece una red estatica por la interfaz de red enp0s3 con la ip: xx
#autonetplan.sh -x -a -s -iface enp0s3 -ip 192.168.1.10 -msk

# Delcaracion variable directorio de configuracion netplan
network_dir=/etc/netplan/01-network-manager-all.yml

if [[ $1 == "-h" || $1 == "--help" ]]; then
    # Mostrar contenido ayuda de la ruta del programa tras ser instalado
    cat /usr/local/bin/help.md
elif [[ $1 == "-v" || $1 == "--version" ]]; then
    cat version
elif [[ $1 == "-r" || $1 == "--remove" ]]; then
# Coidigo eliminacion completa
elif [[ $1 == "-x" || $1 == "--execute" ]]; then
# Seguir con el programa
    # Si se selecciona el modo de edicion manual
    if [[ $2 == "-m" || $2 == "--manual" ]]; then
        sudo nano $network_dir
    #Si se selecciona el modo de edicion automatica
    elif [[ $2 == "-a" || $2 == "--automatic" ]]; then
    echo "Valor automatico correcto"
        # Configuracion automatica
        if [[ $3 == "-f" ||$3 == "--fluid" ]]; then
        echo "Establecendo red por DHCP"
            # Establecer conexion por DHCP
        elif [[ $3 == "-s" || $3 == "--static" ]]; then
        echo "Continuando configuracion por IP Fija"
            # Establecer la ip fija (dhcp4: no)
            if [[ $4 == "-iface" || $4 == "--interface" ]]; then
            echo "Valor interfaz de red correcto"
                # Almacenamiento variable interfaz de red
               read -p "Ingrese la interfaz a usar: " iface
                if [[ $5 == "-ip" ||$5 == "--ipconfigure" ]]; then
                echo "Valor de direccion correcto"
                # Almacenamiento de ip
                read -p "Ingrese la direccion a establecer: " ipdirection
                    if [[ $6 == "-ntmk" || $6 == "--netmask" ]]; then
                        echo "Valor mascara red correcto"
                        # Almacenamiento mascara de red
                        read -p "Ingrese la mascara de red: " netmask
                        if [[ $7 == "-gtw4" || $7 == "--gateway4" ]]; then
                            echo "Valor puerta enlace correcto"
                            # Almacenamiento puerta enlace
                            read -p "Ingrese la puerta de enlace: " gateway4deb
                            #
                            # Agregar valor -> opcion - nuevo controlador de red
                            # Si es asi, llamar a otro programa (este mismo se queda sin parametros)
                            # Boceto establecido
                        else
                            echo "No se ha proporcionado un valor de puerta de enlace valido"
                            exit 0
                    else
                        echo "No se ha proporcionado un valor correcto en el valor de mascara de red"
                        exit 0
                else
                    echo "No se ha ingresado un valor correcto de configuracion por ip"
                    exit 0
                fi
            else
                echo "No se ha seleccionado una valor de interfaz valido"
                exit 0
        else
            echo "Modo de edicion no valido"
            exit 0
        fi
        # Tras los parametros previos, se aplican los cambios
        # Aplicacion de cambios de manera automatica en netplan
        sudo netplan apply
        echo "Configuracion de red aplicada exitosamente"
        # Se pregunta si se desea ver el estado actual de la red
        read -p "¿Desea ver el estado actual de la red? (s/n): " netstatus
        # Condicional - muestra de red
        # Si se permite
        if [[ $netstatus == "s" ]]; then
            sudo ip a
        # Si se niega
        elif [[ $netstatus == "n" ]]; then
            echo "Se ha denegado la observacion preventiva del estado de red."
        # Cualquier otro valor no registrado
        else
            echo "Se ha ingresado un valor no reconocido."
            exit 0
        fi

        # Una vez terminada la configuracion preguntara si se desea guardar una copia de la configuracion
        read -p "¿Desea hacer una copia de la configuracion actual? (s/n): " bkconfig
        # Si se acepta la copia de seguridad
        if [[ $bkconfig == "s" ]]; then
            read -p "¿Donde desea guardar la copia?: " bkconfig_route
            # Almacena el fichero dentro de la ruta,guardandolo como backup ".bk"
            cp $network_dir $bkconfig_route.bk
        # Si se deniega la copia de seguridad
        elif [[ $bkconfig == "n" ]]; then
            echo "Se ha denegado la copia de seguridad"
        else
            echo "Se ha introducido un valor no valido"
            exit 0
        fi
    else
        echo "Modo de configuracion no reconocido"
        exit 0
    fi
elif [[ $1 == " " ]]; then
# Si el input se deja en blanco
    echo "No puedes dejar el valor a introducir en blanco"
else
    echo "Valor incorrecto, asegurese de revisar la linea introducida."
    exit 0
fi