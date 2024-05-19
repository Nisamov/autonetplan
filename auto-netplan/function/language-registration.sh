# Ruta de ficheros del programa
program_files="/usr/local/sbin/auto-netplan"

function language-registration(){
    # Configuracion si no hay un idioma registrado
    # Este codiog se ejcutara cada vez que no se haya registrado el idioma o no se encuentre correctamente registrado
    while true; do
        # Se les preguntara un idioma a registrar
        read -p "[#] Seleccione su lenguaje / Select your language [esp / eng]: " languageregistration
        if [[ $languageregistration == "esp" ]]; then
            # Escribir "ESP" en el fichero
            sudo cat <<EOF > "$program_files/program-files/language.lg"
ESP
EOF
        elif [[ $languageregistration == "eng" ]]; then
        # Escribir "ESP" en el fichero
            sudo cat <<EOF > "$program_files/program-files/language.lg"
ENG
EOF
        else
            echo "[#] Opcion invalida / Invalid option."
        fi
    done
}

# Llamar a la funcion
language-registration