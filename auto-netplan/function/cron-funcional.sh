#!/bin/bash

# Por Andres Ruslan Abadias Otal

# Ruta de ficheros del programa
program_files="/usr/local/sbin/auto-netplan"
# Idioma del programa
language=$(cat "$program_files/program-files/language.lg")

# Esto es un ejemplo del correcto funcionamiento de cron
if [[ $language == "ESP" ]]; then
    echo "[#] El sistema de cron y autonetplan combinados funcionan correctamente."
else
    echo "[#] The cron system and autonetplan combined are working properly."
fi