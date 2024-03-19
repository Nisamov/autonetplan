#!/bin/bash

# Programa generar fichero de reemplazo de red

touch "02-network-manager-all.yml"

# Ingresar contenido en puntos del fichero

# Sustituir por interfaz de red
@ifc
# Configuraicon de red Fluid(DHCP) / Static(IP Fija)
@fs
# Sustituir por la ip
@ip
# Sustituir por mascara de red
@ntmk
# Sustituir por puerta enlace
@linkd
# Ejemplo estructura
network:
  version: 2
  renderer: networkd
  ethernets:
#Configuracion enp0s3:
    @ifc:
      dhcp4: @fs
      addresses: [@ip/@ntmk]
      gateway4: @linkd