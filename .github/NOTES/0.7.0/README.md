# Apuntes Para Version 0.7.0

## Contenido Agregado
Nuevo archivo de actualización: Se ha incluido un archivo específico para la gestión de actualizaciones.
Nuevas rutas temporales para la actualización del software: Implementación de rutas temporales optimizadas para facilitar el proceso de actualización.
Nuevo sistema de actualización de software: Ahora es posible conservar la configuración de versiones anteriores, mejorando la flexibilidad y la gestión de configuraciones.

## Correcciones
Reconocimiento de idioma: Se ha mejorado el sistema de detección del idioma instalado en el equipo, eliminando la necesidad de consultas innecesarias al usuario.
Sistema de reconocimiento de actualizaciones: Ahora se revisa la última actualización publicada utilizando la API de GitHub, garantizando precisión y eficiencia.
Revisión de README.md: Se ha rediseñado el archivo README.md para hacerlo más claro y accesible, facilitando la comprensión para los usuarios.
Refactorización del script autonetplan.sh: El script ha sido dividido en múltiples scripts específicos para distintas acciones, mejorando la organización y legibilidad del código.
Eliminación de archivos e imágenes irrelevantes: Se han eliminado los elementos que no aportaban valor al software, optimizando así el espacio y la limpieza del proyecto.
Corrección de la salida del software: Se ha ajustado el sistema de salida para reflejar correctamente los diferentes tipos de errores:
exit 1: Error debido a valores ingresados incorrectos.
exit 2: Problema con el archivo de configuración.
Corrección de mensajes durante la instalación: Se han corregido los errores de formato en los mensajes, garantizando una salida de información clara y profesional.
Ajustes en el formato de traducción de mensajes: Se ha mejorado la coherencia y precisión en la traducción de los mensajes.
Corrección del sistema de actualización: Se han ajustado las rutas y solucionado problemas de funcionamiento detectados en versiones previas.
Incorporación de nuevos parámetros de ejecución: Se han agregado los parámetros -p, -d y -clg para mejorar la funcionalidad y flexibilidad durante la ejecución del software.
Revisión de la sección de interacción con el archivo de red: Se ha revisado y mejorado la funcionalidad de las interacciones con el archivo de red, asegurando una operación más robusta.

## Problemas actuales

## Prevision para futuras actualizaciones
- Configurar la red mediante una interfaz