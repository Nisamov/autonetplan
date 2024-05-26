#!/bin/bash
# Por Andres Ruslan Abadias Otal

# Variables
old_config="/etc/autonetplan/autonetplan.conf"
new_config="/usr/local/sbin/auto-netplan/temp/auneconf/autonetplan.conf"


program_files="/usr/local/sbin/auto-netplan"
# Idioma del programa
language=$(cat $program_files/program-files/language.lg)

# Función para actualizar el valor en el nuevo fichero
update_config_value() {
    local key="$1"
    local value="$2"
    if grep -q "^${key}=" "$new_config"; then
        sed -i "s|^${key}=.*|${key}=${value}|" "$new_config"
    else
        echo "${key}=${value}" >> "$new_config"
    fi
}

# Leer y actualizar las líneas del fichero viejo
while IFS='=' read -r key value; do
    case "$key" in
        "autonetplan-netplan-route-config" | \
        "autonetplan-formatted-on-call" | \
        "autonetplan-prevent-purge-on-mistake" | \
        "autonetplan-automate-backup" | \
        "autonetplan-update-program" | \
        "autonetplan-automate-update" | \
        "autonetplan-enable-search" | \
        "autonetplan-file-existence" | \
        "autonetplan-directory-existence" | \
        "file-existence-config-file" | \
        "file-existence-autonetplansh-file" | \
        "file-existence-license-file" | \
        "file-existence-version-file" | \
        "file-existence-language-file" | \
        "file-existence-update-file" | \
        "dir-existence-config-dir" | \
        "dir-existence-program-files-dir")
            # Eliminar espacios en blanco al final de value
            value=$(echo "$value" | sed 's/[[:space:]]*$//')
            if [[ $languag == "ESP" ]]; then
                echo "[#] Actualizando ${key}..."
            elif [[ $languag == "ENG" ]]; then
                echo "[#] Updating ${key}..."
            else
                echo "[#] Updating ${key}..."
            fi
            update_config_value "$key" "$value"
            ;;
    esac
done < <(grep -E '^(autonetplan-netplan-route-config|autonetplan-formatted-on-call|autonetplan-prevent-purge-on-mistake|autonetplan-automate-backup|autonetplan-update-program|autonetplan-automate-update|autonetplan-enable-search|autonetplan-file-existence|autonetplan-directory-existence|file-existence-config-file|file-existence-autonetplansh-file|file-existence-license-file|file-existence-version-file|file-existence-language-file|file-existence-update-file|dir-existence-config-dir|dir-existence-program-files-dir)=' "$old_config")

if [[ $languag == "ESP" ]]; then
    echo "[#] Ajustes del fichero de configuracion guardados correctamente."
elif [[ $languag == "ENG" ]]; then
    echo "[#] Configuration file settings saved correctly."
else
    echo "[#] Configuration file settings saved correctly."
fi