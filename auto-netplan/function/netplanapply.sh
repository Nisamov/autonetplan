#!/bin/bash
# Por Andres Ruslan Abadias Otal

function netplanapply(){
    # Preguntar si aplicar cambios de red
    read -p "¿Desea aplicar los cambios antes de continuar? [s/n]: " netwapply
    if [[ $netwapply == "s" ]]; then
        sudo netplan apply
    elif [[ $netwapply == "n" ]]; then
        echo -e "[\e[31m#\e[0m] Se ha denegado la aplicacion de cambios."
    else
        # Mensaje rojo - referencia
        echo -e "[\e[31m#\e[0m] Se ha introducido un valor no registrado."
        # Mensaje verde - referencia
        echo -e "[\e[32m#\e[0m] Se han aplicado los cambios por seguridad."
        sudo netplan apply
    fi
}

# Llamada a la funcion netplanapply
netplanapply