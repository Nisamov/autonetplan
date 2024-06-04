#!/bin/bash

# Ruta de ficheros del programa
program_files="/usr/local/sbin/auto-netplan"
# Idioma del programa
language=$(cat "$program_files/program-files/language.lg")

# Verificar codigo de salida del software AutoNetplan

# Aviso de valores maximos permitidos
if [[ $language == "ESP" ]]; then
    echo "[#] Este script unicamente es para probar el funcionamiento del software, cuentas con un maximo de 3 parametros permitidos."
    echo "[#] Si deseas ampliar el numero de parametros a usar, puedes cambiar la cantidad en '/usr/local/sbin/auto-netplan/function/verify-exitcode.sh'."
else
    echo "[#] This script is only for testing the operation of the software, you have a maximum of 3 parameters allowed."
    echo "[#] If you want to extend the number of parameters to use, you can change the number in '/usr/local/sbin/auto-netplan/function/verify-exitcode.sh'."
fi

if [[ $language == "ESP" ]]; then
    read -p "[#] Ingrese primer parametro: " firstparam
    read -p "[#] Ingrese segundo parametro: " secondparam
    read -p "[#] Ingrese tercer parametro: " thirdparam
else
    read -p "[#] Enter first parameter: " firstparam
    read -p "[#] Enter second parameter: " secondparam
    read -p "[#] Enter third parameter: " thirdparam
fi

# Llamar al software
sudo bash "/usr/local/sbin/autonetplan" $firstparam $secondtparam $thirdparam

# Revisar codigo de salida
# Output valor de salida
if [ $? -eq 0 ]; then
    if [[ $language == "ESP" ]]; then
        echo -e "[\e[32m#\e[0m] Ejecucion finalizada correctamente."
        echo ""
        echo -e "[\e[32m#\e[0m] Codigo de salida '$?'."
    else
        echo -e "[\e[32m#\e[0m] Execution successfully completed."
        echo ""
        echo -e "[\e[32m#\e[0m] Exit code '$?'."
    fi
elif [ $? -eq 1 ]; then
    if [[ $language == "ESP" ]]; then
        echo -e "[\e[31m#\e[0m] Error de valores ingresados."
        echo ""
        echo -e "[\e[32m#\e[0m] Codigo de salida '$?'."
    else
        echo -e "[\e[31m#\e[0m] Entry of erroneous values."
        echo ""
        echo -e "[\e[32m#\e[0m] Exit code '$?'."
    fi
elif [ $? -eq 2 ]; then
    if [[ $language == "ESP" ]]; then
        echo -e "[\e[31m#\e[0m] Configuracion deshabilitada o inexistente."
        echo ""
        echo -e "[\e[32m#\e[0m] Codigo de salida '$?'."
    else
        echo -e "[\e[31m#\e[0m] Disabled or non-existent configuration."
        echo ""
        echo -e "[\e[32m#\e[0m] Exit code '$?'."
    fi
fi