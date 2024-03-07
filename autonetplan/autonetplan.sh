#!/bin/bash
#Programa 


# Delcaracion variable directorio de configuracion netplan
network_dir=/etc/netplan/01-network-manager-all.yml

if [[ $1 == "-h" || $1 == "--help" ]]; then
    cat help.md
elif [[ $1 == "-v" || $1 == "--version" ]]; then
    cat version
elif [[ $1 == "-r" || $1 == "--remove" ]]; then
# Coidigo eliminacion completa
elif [[ $1 == "-x" || $1 == "--execute" ]];
# Seguir con el programa
    # Si se selecciona el modo de edicion manual
    if [[ $2 == "-m" || $2 == "--manual" ]]; then
        sudo nano $network_dir
    #Si se selecciona el modo de edicion automatica
    elif [[ $2 == "-a" || $2 == "--automatic" ]]; then
        # Configuracion automatica

        # Codigo (por establecer parametros y valor de configuracion)

        # Una vez terminada la configuracion preguntara si se desea guardar una copia de la configuracion
        read -p "¿Desea hacer una copia de la configuracion actual? (s/n): " bkconfig
        # Si se acepta la copia de seguridad
        if [[ $bkconfig == "s" ]];
            read -p "¿Donde desea guardar la copia?: " bkconfig_route
            # Almacena el fichero dentro de la ruta,guardandolo como backup ".bk"
            cp $network_dir $bkconfig_route.bk
        # Si se deniega la copia de seguridad
        if [[ $bkconfig == "n" ]];
            echo "Se ha denegado la copia de seguridad"
        else
            echo "Se ha introducido un valor no valido"
        fi
    exit 1
elif [[ $1 == " " ||  ]]; then
# Si el input se deja en blanco
    echo "No puedes dejar el valor a introducir en blanco"
else
    echo "Valor incorrecto, asegurese de revisar la linea introducida."
fi
exit 0