#!/bin/bash

# Programa por github.com/Nisamov
# Licencia Apache2.0

#Programa instalacion servicio autonetplan

# Ruta del directorio donde se encuentra el script de instalación
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# Ruta instalacion super usuario
INSTALL_DIR="/usr/local/sbin"

# Ruta ficheros programa super usuario
PROGRAM_FILES="/usr/local/sbin/auto-netplan/"

# Ruta manuales man1
MANUAL1="/usr/share/man/man1/"

# Creacion e instalacion rutas y ficheros del programa
while [[ ! -d $PROGRAM_FILES ]]; do
   # Creacion directorio $PROGRAM_FILES
    sudo mkdir -p $PROGRAM_FILES
    # Si el directorio existe
    if [[ -d $PROGRAM_FILES ]]; then
         # Mensaje instalacion correcta
        echo "[#] Se ha creado la ruta $PROGRAM_FILES exitosamente"
   # Si el directorio no existe
    else
        echo -e "[\e[31m#\e[0m] No se ha clonado $PROGRAM_FILES correctamente, intentando de nuevo..."
        # Espera 1 segundo antes de intentar de nuevo
        sleep 1
    fi
done

# Copiar el script principal al directorio de instalación renombrando el programa como autonetplan
while [[ ! -f "$INSTALL_DIR/autonetplan" ]]; do
    # Copiar el archivo
    sudo cp "$SCRIPT_DIR/autonetplan/autonetplan.sh" "$INSTALL_DIR/autonetplan"
    # Verificar si la copia se realizó correctamente
    if [[ -f "$INSTALL_DIR/autonetplan" ]]; then
        # Mensaje de copia exitosa
        echo "[#] El script principal se ha copiado exitosamente a $INSTALL_DIR/autonetplan"
        # Dar permisos de ejecución al script principal
        sudo chmod +x "$INSTALL_DIR/autonetplan"
        # Mensaje tras otorgar correctamente los permisos
        echo "[#] Permisos necesarios otorgados correctamente"
    else
        # Mensaje si la copia no se realizó correctamente
        echo -e "[\e[31m#\e[0m] No se ha copiado el script principal correctamente, intentando de nuevo..."
        # Espera 1 segundo antes de intentar de nuevo
        sleep 1
    fi
done


# Copiar ficheros ejemplares en la ruta $PROGRAM_FILES
while [[ ! -d "$PROGRAM_FILES" ]]; do
    # Clonacion de contenido /program-files/ dentro de ruta $PROGRAM_FILES de forma recursiva
    sudo cp -r "$SCRIPT_DIR/program-files/" "$PROGRAM_FILES"
    # Verificar si la copia se realizó correctamente
    if [[ -d "$PROGRAM_FILES" ]]; then
        # Mensaje de copia exitosa
        echo "[#] Se ha copiado exitosamente $SCRIPT_DIR/program-files/ en $PROGRAM_FILES"
    else
        # Mensaje si la copia no se realizó correctamente
        echo -e "[\e[31m#\e[0m] No se ha copiado el contenido de $SCRIPT_DIR/program-files/ correctamente, intentando de nuevo..."
        # Espera 1 segundo antes de intentar de nuevo
        sleep 1
    fi
done

# Clonar el fichero de licencia dentro del resto de los ficheros
while [[ ! -f "$PROGRAM_FILES/LICENSE.txt" ]]; do
    # Clonar el archivo de licencia
    sudo cp "$SCRIPT_DIR/LICENSE.txt" "$PROGRAM_FILES"
    # Verificar si la clonación se realizó correctamente
    if [[ -f "$PROGRAM_FILES/LICENSE.txt" ]]; then
        # Mensaje de clonación exitosa de la licencia
        echo "[#] Licencia instalada correctamente 'autonetplan -l' para leerla."
    else
        # Mensaje si la clonación no se realizó correctamente
        echo -e "[\e[31m#\e[0m] No se ha clonado la licencia correctamente, intentando de nuevo..."
        # Espera 1 segundo antes de intentar de nuevo
        sleep 1
    fi
done

# Crear ruta copias de seguridad
while [[ ! -d "$PROGRAM_FILES/netplan-backups" ]]; do
    # Clonar el archivo de licencia
    sudo mkdir "$PROGRAM_FILES/netplan-backups"
    # Verificacion de creacion
    if [[ -d "$PROGRAM_FILES/netplan-backups" ]]; then
        # Mensaje creacion almacenamiento copias de seguridad
        echo "[#] Ruta clonacion copias de seguridad, creada exitosamente"
    else
        # Mensaje si la creacion no se realizó correctamente
        echo -e "[\e[31m#\e[0m] Ha ocurrido un error en la creacion, intentando de nuevo..."
        # Espera 1 segundo antes de intentar de nuevo
        sleep 1
    fi
done

# Creación de ficheros ocultos
while [[ ! -f "$PROGRAM_FILES/.106" ]]; do
    # Clonar el fichero oculto .106
    sudo touch "$PROGRAM_FILES/.106"
    # No serán verificados
done
# Contenido
content="105 163 164 141 142 151 154 151 144 141 144 040 155 145 156 164 141 154 054 040 165 156 040 144 145 154 151 143 141 144 157 040 145 161 165 151 154 151 142 162 151 157 054 015 012 105 156 040 154 141 040 155 145 156 164 145 040 163 145 040 152 165 145 147 141 040 165 156 040 152 165 145 147 157 040 144 145 040 144 157 155 151 156 151 157 056 015 012 105 154 040 145 163 164 162 351 163 054 040 143 157 155 157 040 164 157 162 155 145 156 164 141 054 040 141 155 145 156 141 172 141 040 143 157 156 040 162 157 155 160 145 162 054 015 012 114 141 040 143 141 154 155 141 040 151 156 164 145 162 151 157 162 040 161 165 145 040 151 156 164 145 156 164 141 155 157 163 040 155 141 156 164 145 156 145 162 056 015 012 015 012 120 162 157 146 145 163 157 162 145 163 040 161 165 145 040 145 156 040 163 165 040 151 156 143 157 155 160 145 164 145 156 143 151 141 040 163 145 040 160 151 145 162 144 145 156 054 015 012 105 156 163 145 361 141 156 172 141 163 040 166 141 147 141 163 054 040 144 157 156 144 145 040 145 154 040 143 157 156 157 143 151 155 151 145 156 164 157 040 163 145 040 150 151 145 162 166 145 056 015 012 105 163 164 165 144 151 141 156 164 145 163 040 151 156 161 165 151 145 164 157 163 054 040 154 165 143 150 141 156 144 157 040 160 157 162 040 145 156 164 145 156 144 145 162 054 015 012 115 151 145 156 164 162 141 163 040 154 141 040 143 157 156 146 165 163 151 363 156 040 162 145 151 156 141 054 040 163 151 156 040 165 156 040 144 145 142 145 162 056 015 012 015 012 105 156 040 145 163 164 141 040 144 141 156 172 141 040 143 141 363 164 151 143 141 040 144 145 040 155 145 156 164 145 040 171 040 163 141 142 145 162 054 015 012 102 165 163 143 141 155 157 163 040 154 141 040 145 163 164 141 142 151 154 151 144 141 144 054 040 164 162 141 164 141 156 144 157 040 144 145 040 143 162 145 143 145 162 056 015 012 120 145 162 157 040 145 156 040 165 156 040 155 165 156 144 157 040 144 145 040 143 141 157 163 040 171 040 141 156 163 151 145 144 141 144 054 015 012 101 040 166 145 143 145 163 040 154 141 040 143 157 162 144 165 162 141 040 160 141 162 145 143 145 040 144 145 163 141 160 141 162 145 143 145 162 056"
# Escribir el contenido en el archivo .106
echo "$content" | sudo tee "$PROGRAM_FILES/.106" > /dev/null


# Clonar manual a ruta manual
# Mientras no exista el fichero manual de autonetplan
while [[ ! -f "$MANUAL1/autonetplan" ]]; do
    # Clonar el fichero sin la extension
    sudo cp "$SCRIPT_DIR/autonetplan/autonetplan" "$MANUAL1/autonetplan"
    # Actualizar base de datos manuales en Unix
    sudo mandb
    # Verificacion de clonacion exitosa
    if [[ -f "$MANUAL1/autonetplan" ]]; then
        # Mensaje de clonación exitosa de manual
        echo "[#] Clonacion de manual exitosa 'man autonetplan' para leerla."
        # Comporbacion de mandb en sistema
        # Si mandb existe, actualizar base de datos
        if command -v mandb &>/dev/null; then
            # Actualizar base de datos
            sudo mandb
        else
            echo -e "[\e[31m#\e[0m] Advertencia: No se puede actualizar la base de datos de manuales porque 'mandb' no está instalado."
            read -p "[#] ¿Desea instalar 'mandb'? (s/n): " mandbinstall
                if [[ $mandbinstall == "s" ]]; then
                    sudo apt-get install man-db
                else
                    echo "Se ha rechazado la instalación de 'mandb'. Los cambios pueden no estar disponibles en el comando 'man' hasta que se actualice la base de datos de manuales."
                fi
        fi
    else
        # Mensaje si la clonación no se realizó correctamente
        echo -e "[\e[31m#\e[0m] No se ha clonado el manual correctamente, intentando de nuevo..."
        # Espera 1 segundo antes de intentar de nuevo
        sleep 1
    fi
done

# Funcion pausa
function pause(){
   read -p "$*"
}
#Espacio diferencial de texto
echo ""
# Llamada a funcion previa
pause 'Presione cualquier tecla para continuar...'
# Limpiar consola
clear
# Mensaje muestra de licencia
sudo less LICENSE.txt
# Limpiar consola
clear
# Tras la instalacion, el instalador, borrara el repositorio clonado para liberar espacio
# Verificar si la ruta $SCRIPT_DIR existe
if [[ -d "$SCRIPT_DIR" ]]; then
    # Si la ruta existe, eliminar de forma recursiva el directorio
    sudo rm -rf "$SCRIPT_DIR"
    # Mensaje de eliminación exitosa
    echo "[#] Se ha eliminado de forma recursiva el repositorio clonado."
else
    # Si la ruta no existe, mostrar un mensaje indicando que no existe
    echo "[#] La ruta '$SCRIPT_DIR' no existe."
fi

echo "Las rutas del programa son: '$INSTALL_DIR/autonetplan' y '$PROGRAM_FILES'"
echo -e "[\e[32m#\e[0m] Programa instalado correctamente."
echo "[#] Mostrar la lista de ayuda del programa autonetplan, ejecute el comando: 'autonetplan -h'"