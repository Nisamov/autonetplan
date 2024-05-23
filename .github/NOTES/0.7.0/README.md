# Apuntes Para Version 0.7.0

## Contenido agregado
- Nuevo fichero de actualizacion
- Nuevas rutas temporales para la actualizacion del software

## Correcciones
- Corregido el reconocimiento de idioma (Ahora el software revisara el idioma instalado en el equipo, para evitar perder tiempo preguntando)
- Corregido el sistema de reconocimiento de actualizaciones (Se revisara la ultima actualizacion publicada siguiendo la API de GitHub)
- Corregido el README.md y su diseño confuso, se ha agregado un estilo más cómodo y sencillo para los lectores
- Se ha divido el script autonetplan.sh en diferentes scripts que ejecuten diferentes acciones, evitando acumular codigo (Orden y Legibilidad)
- Se han eliminado ficheros e imagenes poco relevantes para el software
- Se ha corregido la salida del software (exit 1 = salida por valores ingresados erroneos | exit 2 = salida por problema con fichero de configuracion)
- Se ha corregido el output durante la instalacion, corrigiendo errores de mensajes sin formato
- Se ha corregido el formato de traduccion de algunos mensajes.
- Se ha corregido el sistema de actualizacion, rutas mal especificadas y mal funcionamiento durante versiones previas

## Problemas actuales
- Se limpia el fichero yaml de /etc/netplan/*.yaml pero no aplica la configuracion de red esperada, no se agrega nada dentro del fichero

## Prevision para futuras actualizaciones
- Proceso de actualizacion sin perder la configuracion establecida en versiones viejas
- Configurar la red mediante una interfaz