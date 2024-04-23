# Modelo en desarrollo
# Este codigo es la correcion de autonetplan.sh debido a fallos catastroficos en el programa
# Por Andres Abadias

# Declaracion variable directorio de configuracion netplan
network_dir="/etc/netplan/00-installer-config.yaml"
work_dir="/usr/local/sbin"
program_files="/usr/local/sbin/auto-netplan/"
INSTALL_DIR="/usr/local/sbin"

# Proxima actualizacion -> este "help" ubicar en ruta /usr/local/sbin/auto-netplan/autonetplan.help
# Al llamar, este sera expuesto con cat (ruta)
function aune-help(){
    # Comprobar que el fichero existe
    if [[ -f "$program_files/program-files/autonetplan.man" ]]; then
    
    else
    # Aviso de problema (no crear fichero - tiempo innecesario)

    fi
}

function aune-remove(){
    # Funcion desinstalar programa
    sudo rm -rf $program_files
    sudo rm -f $INSTALL_DIR/autonetplan
}

function aune-backup(){
    # Funcion guardar copia de seguridad con numero progresivo para evitar reemplazar ficheros
    local backup_number=0
    local backup_file
    echo "[#] Copiando fichero $network_dir..."
    sudo cp "$network_dir" "$network_dir.bk"
    echo "[#] Copia completada."
}

function netplanapply(){
    # Preguntar si aplicar cambios de red
    read -p "Desea aplicar los cambios antes de continuar? (s/n): " netwapply
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

function aune-networked(){
    # Configuracion de red por autonetplan
            echo "Configuración de red por configuracion automatica..."
            sudo cat <<EOF > "$network_dir"
# Editado con autonetplan
network:
  version: 2
  renderer: networkd
  ethernets:
    $iface:
      dhcp4: $ipfigured
      addresses: [$ipconfigure/$masked]
      gateway4: $linkeddoor
EOF
}

function comment-network(){
    file_route="/usr/local/sbin/autonetplan"
    # Esta función solo se ejecutará si se ha establecido una IP dinámica.
    # La función sirve para comentar:
    #   - addresses: [$ipconfigure/$masked]
    #   - gateway4: $linkeddoor
    # Esto permite posibles problemas de conexión por parte de netplan.

    # Leer el archivo línea por línea
    while IFS= read -r linea; do
        # Imprimir todas las líneas del archivo
        echo "$linea"
        # Verificar si la línea contiene "addresses:" o "gateway4:"
    if [[ $linea == *"addresses:"* || $linea == *"gateway4:"* ]]; then
        # Si lo tiene, agregar un "#" delante de la línea entera
        echo "# $linea"
    fi
    done < "$file_route"
}

# Si es de color rojo el aviso = importante revisar
#   [\e[31m#\e[0m] >> # rojo
# Si es de color amarillo el aviso = sugerencia o no obligatorio
#   [\e[33m!!\e[0m] >> !! amarillo
# Si es de color verde el aviso = todo realizado correctamente

if [[ $1 == "-h" || $1 == "--help" ]]; then
    # Mostrar ayuda de la ruta raiz, tras haber instalado el programa
    # Llamada de funcion ayuda
        aune-help
elif [[ $1 == "-r" || $1 == "--remove" ]]; then
    # Llamada de funcion aune-remove
        aune-remove
elif [[ $1 == "-b" || $1 == "--backup" ]]; then
    # Creacion de copia de seguridad de configuracion de red
    # Llamada a funcion aune-backup
        aune-backup
elif [[ $1 == "-l" || $1 == "--license" ]]; then
    # Lectura de fichero de licencia
        sudo less "$program_files/LICENSE.txt"
# Continuacion con el programa
elif [[ $1 == "-x" || $1 == "--execute" ]]; then
    # Continuacion de programa
    if [[ $2 == "-m" || $2 == "--manual" ]]; then
        sudo nano "$network_dir"
    elif [[ $2 == "-a" || $2 == "--automatic" ]]; then
        # Configuracion automatica
        if [[ $3 == "-iface" || $3 == "--interface" ]]; then
                # Preguntar por interfaz de red a usar
                read -p "Ingrese la interfaz de red a usar: " iface
                # Continuacion de programa
            if [[ $3 == "-f" || $3 == "--fluid" ]]; then
                # Configuracion de red por DHCP
                echo "Configuración de red seleccionada con conexion por DHCP"
                ipfigured="yes"
            elif [[ $3 == "-s" || $3 == "--static" ]]; then
                # Configuracion de red por ip estatica
                echo "Configuración de red seleccionada con conexion por ip estatica"
                ipfigured="no"
                # Continuacion de programa
                if [[ $5 == "-ip" || $5 == "--ipconfigure" ]]; then
                    # Preguntar por ip a almacenar
                    read -p "Ingrese la direccion IP a usar: " ipconfigure
                    if [[ $6 == "-ntmk" || $6 == "--netmask" ]]; then
                        # Preugntar por mascara de red a agregar
                        read -p "Ingrese la mascara de red a agregar: " masked
                        if [[ $7 == "-lnkd" || $7 == "--linkeddoor" ]]; then
                            # Preguntar por puerta de enlace
                            read -p "Ingrese una puerta de enlace: " linkeddoor
                        else
                            # Mensaje por error de valores
                            echo -e "[\e[33m!!\e[0m] No se ha ingresado una puerta de enlace: '-ntmk'."
                        fi
                        # Llamada del programa configuracion completa
                        aune-networked

                        # Si "ipfigured" = yes = configuracion por dhcp activada, segun eso se aplicara o no la funcion "comment-network"
                        if [[ $ipfigured == "yes" ]]; then
                        # Configuracion por DHCP activada
                            # Llamada a la funcion "comment-network"
                            comment-network

                        elif [[ $ipfigured == "no" ]]; then
                        # Configuracion por DHCP no activada, red estatica - color amarillo
                            echo -e "[\e[33m#\e[0m] La configuracion de red esta establecida de forma estatica"
                        else
                        # No se ha aplicado configuracion, aviso importante
                            echo -e "[\e[31m#\e[0m] [\e[33m!!\e[0m] - Configuracion de red no aplicada, importante revisar"
                        fi

                        # Tras la configuracion, preguntar si guardar cambios
                        # Llamada a la funcion de aplicacion de cambios en fichero netplan
                        netplanapply
                    else
                        # Mensaje por error de valores
                        echo -e "[\e[31m#\e[0m] Error de valores ingresados: '-ntmk'."
                        # Error por ingreso de valores erroneos
                        exit 1
                    fi
                else
                    # Mensaje por error de valores
                    echo -e "[\e[31m#\e[0m] Error de valores ingresados: '-ip'."
                    # Error por ingreso de valores erroneos
                    exit 1
                fi
            else
                # Mensaje por error de valores
                echo -e "[\e[31m#\e[0m] Error de valores ingresados: '-f' o '-s'."
                # Error por ingreso de valores erroneos
                exit 1
            fi
        else
            # Mensaje por error de valores
            echo -e "[\e[31m#\e[0m] Error de valores ingresados: '-iface' o '--interface'."
            # Error por ingreso de valores erroneos
            exit 1
        fi
    else
        # Mensaje por error de valores
        echo -e "[\e[31m#\e[0m] Error de valores ingresados: '-m' o '-a'."
        # Error por ingreso de valores erroneos
        exit 1
    fi
else
    # Mensaje por error de valores
    echo -e "[\e[31m#\e[0m] Error de valores ingresados: '-h', '-r', '-b', '-l' o '-x'."
    # Error por ingreso de valores erroneos
    exit 1
fi