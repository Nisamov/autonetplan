# Auto actualizaciones del programa
auto_update=$(grep "^autonetplan-update-program" "$program_config" | cut -d "=" -f2)

# Funcion de auto actualizacion
function aune-update(){
    if [[ $auto_update == "true" ]]; then
        echo "[#] La configuracion 'autonetplan-update-program' esta establecida como 'true'."
        # Revisar actualizacion y comparar
        # Obtener la ultima version desde GitHub sobre el programa
        latest_release=$(curl -s https://api.github.com/repos/Nisamov/autonetplan/releases | jq .[0].name)
        # Obtener ultima version
        # Extraer el numero de version del nombre del release
        latest_version=$(echo "$latest_release" | sed -n 's/.*v\([0-9]\+\.[0-9]\+\.[0-9]\+\).*/\1/p')

        # Verificar si hay una nueva version disponible
        if [[ "$latest_version" != "$current_version" ]]; then
            echo "¡Nueva version disponible! Version actual: $current_version, Última version: $latest_version"
            # Actualizar directamente
            # COdigo de actualizacion
        else
            echo "Tu programa ya esta actualizado. Version actual: $current_version"
        fi
    else

    fi

}