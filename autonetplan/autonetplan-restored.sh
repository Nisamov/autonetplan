# Modelo en desarrollo
# Este codigo es la correcion de autonetplan.sh debido a fallos catastroficos en el programa
# Por Andres Abadias

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
                ipfigured="no"
            elif [[ $3 == "-s" || $3 == "--static" ]]; then
                # Configuracion de red por ip estatica
                echo "Configuración de red seleccionada con conexion por ip estatica"
                ipfigured="false"
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
                                echo -e "[\e[31m#\e[0m] No se ha ingresado una puerta de enlace: '-ntmk'."
                            fi
                            # Llamada del programa configuracion completa
                            aune-networked
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
                    echo -e "[\e[31m#\e[0m] Error de valores ingresados: '-iface'."
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