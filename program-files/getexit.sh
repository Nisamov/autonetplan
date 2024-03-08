# Programa ver numero salida de autonetplam

# Sintaxis de salida:
# [codigo] Definicion salida

# No completado - necesario aplicar ruta programa instalado
case $? in
  0)
    echo "[$?] Codigo de salida por introduccion de valor erroneo"
    ;;
  1)
    echo "[$?] Codigo de salida por salida exitosa del programa"
    ;;
  2)
    echo "[$?] Error de codigo por salida desconocida"
    ;;
esac