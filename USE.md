# Información General - Comandos, Estructura y Ejecución:

## Estructura y descripción de ordenes
```sh
autonetplan $1 $2 $3 $4 $5 $6
├── $1	            -d	    --debug             Modo de prueba del software	                        autonetplan -d
├── $1	            -h	    --help	            Mostrar ayuda rápida del programa	                autonetplan -h
├── $1	            -p	    --ping	            Confirmar si el programa recibe las peticiones	    autonetplan -p
├── $1	            -r	    --remove	        Desinstalar el software	                            autonetplan -r
├── $1	            -l	    --license	        Mostrar licencia del software	                    autonetplan -l
├── $1	            -b	    --backup	        Crear copia seguridad fichero .yaml de red	        autonetplan -b
├── $1	            -u	    --update	        Actualizar el software	                            autonetplan -u
├── $1	            -v	    --version	        Mostrar versión del software	                    autonetplan -v
├── $1	            -m	    --manual	        Mostrar instrucciones y config avanzada	            autonetplan -m
├── $1	            -i	    --integrity	        Revisar integridad del software	                    autonetplan -i
├── $1	            -ntf	--netfileenabled	Mostrar ruta de fichero de red establecido	        autonetplan -ntf
├── $1	            -clg	--changelanguage	Cambiar el idioma del software	                    autonetplan -clg
├── $1	            -excd	--exitcode	        Mostrar código de salida por ejecución de prueba	autonetplan -excd
├── $1	            -s	    --schedule	        Programar acciones	                                autonetplan -s
│   ├── $2          -b      --backup            Programar copias de seguridad                       autonetplan -s -b
│   └── $2          -u      --update            Programar actualizaciones                           autonetplan -s -u
└── $1	            -x	    --execute	        Continuación con la ejecución	                    autonetplan -x
    ├── $2	        -m	    --manual	        Configuración de red manual	                        autonetplan -x -m
    ├── $2	        -a	    --automatic	        Configuración de red automática	                    autonetplan -x -a
    ├── $3	        -iface	--interface	        Ingreso de interfaz de red	                        autonetplan -x -a -iface
    ├── $4	        -f	    --fluid	            Configuración DHCP True (Ip Dinámica)	            autonetplan -x -a -iface -f
    └── $4	        -s	    --static	        Configuración DHCP False (Ip Estática)	            autonetplan -x -a -iface -s
        ├── $5	    -ntcd	--networkcard	    Configurar otra tarjeta de red sin puerta de enlace	autonetplan -x -a iface -s -ntcd
        └── $5	    -lnkd	--linkeddoor	    Puerta de enlace para el cliente	                autonetplan -x -a -iface -s -lnkd
            └── $6	-ntcd	--networkcard	    Configurar otra tarjeta de red	                    autonetplan -x -a iface -s -lnkd -ntcd
```

## Ejecucion de comandos:
**Debug:** Modo de prueba del software
```sh
autonetplan -d
```
**Help:** Mostrar ayuda rápida del programa
```sh
autonetplan -h
```
**Ping:** Confirmar si el programa recibe las peticiones
```sh
autonetplan -p
```
**Remove:** Desinstalar el software
```sh
autonetplan -r
```
**License:** Mostrar licencia del software
```sh
autonetplan -l
```
**Backup:** Crear copia seguridad fichero .yaml de red
```sh
autonetplan -b
```
**Update:** Actualizar el software
```sh
autonetplan -u
```
**Version:** Mostrar versión del software
```sh
autonetplan -v
```
**Manual:** Mostrar instrucciones y config avanzada
```sh
autonetplan -m
```
**Integrity:** Revisar integridad del software
> [!] Las siguientes configuraciones deben encontrarse en 'true' segun lo que se desee buscar, la ruta de la configuracion es: /etc/autonetplan/autonetplan.conf
```conf
# Esta opcion habilita la investigacion de las siguientes dos
autonetplan-enable-search=true
# Esta opcion realiza la busqueda de ficheros
autonetplan-file-existence=true
# Esta opcion realiza la busqueda de directorios
autonetplan-directory-existence=true
```
```sh 
autonetplan -i
```
**Netfileenabled:** Mostrar ruta de fichero de red establecido
```sh
autonetplan -ntf
```
**Changelanguage:** Cambiar el idioma del software
```sh
autonetplan -clg
```
**Exitcode:** Mostrar código de salida por ejecución de prueba
```sh
autonetplan -excd
```
**Schedule:** Programar acciones
> [!] Esta opcion no realizara ninguna accion si se hace sola, es necesario ingresar mas parametros para realizar tareas mas especificas
```sh
autonetplan -s
```
```sh
# Programar copias de seguridad
autonetplan -s -b
# Programar revision por actualizacion del software
autonetplan -s -u
```
**Execute:** Continuación con la ejecución
```sh
autonetplan -x
```
```sh
# Configuración de red manual
autonetplan -x -m
# Configuración de red automática
autonetplan -x -a
```