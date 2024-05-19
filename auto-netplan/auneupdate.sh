#!/bin/bash

# Instalar git
sudo apt install git
# Crear deposito temporal
sudo mkdir -r "/usr/local/sbin/autonetplan/temp/"
# Descargar version mas reciente
git clone "https://github.com/Nisamov/autonetplan" "/usr/local/sbin/autonetplan/temp/"
# Ir a la ruta y sustituir ficheros
# Al sustituir ficheros, se borraran las configuraciones, regresando a las estandar
