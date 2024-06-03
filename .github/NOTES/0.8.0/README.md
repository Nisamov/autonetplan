# Apuntes Para Version 0.8.0

## Contenido Agregado

Se utiliza [ShellCheck](https://github.com/koalaman/shellcheck) para revisar la integridad de los scripts
Se ha completado la traduccion al ingles
Se ha corregido la pagina web (nav:top)

## Correcciones

Corrección de manejo de valores erróneos:
- Se ha ajustado el comportamiento del sistema para que, en caso de no ingresar contenido, se muestre una salida diferente a la previamente mostrada.
- En caso de ingresar un valor diferente al registrado, el sistema ahora genera una salida nueva y adecuada.
Eliminación de solicitud de guardado constante:
- Se ha eliminado la función de solicitud de guardado constante, optimizando así el rendimiento y la experiencia del usuario.
Corrección del parámetro '-ntcd':
- Se ha corregido el parámetro '-ntcd', el cual previamente no se aplicaba correctamente. Ahora, su funcionamiento es el esperado.
Limpieza de código:
- Se han eliminado líneas de código innecesarias y no utilizadas para mejorar la legibilidad y mantenibilidad del código.
- Se han eliminado funciones mal programadas, optimizando así el rendimiento general del sistema.