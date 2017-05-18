#!/bin/bash

# Este es un script para descargar secuencias de Illumina.
# Cuando te solicite el nombre de usuario y contraseña escribe lo siguiente
# usuario: MYcroarray
# contraseña: 170109bgsogp01010304data
#
# escribir: gsl_wget_download.sh <file list>
#
#

DL_LIST=$1
if [ -z "$DL_LIST" ]; then
    echo "usage: gsl_wget_download.sh <file list>"
else
    echo -n "username: "
    read GSL_USERNAME
    echo -n "password: "
    stty -echo
    read GSL_PASSWORD
    stty echo
    touch .wgetrc
    chmod go-rwx .wgetrc
    echo -e "user = ${GSL_USERNAME}\npassword = ${GSL_PASSWORD}" > .wgetrc
    export WGETRC=`pwd`/.wgetrc

    wget -c -i $DL_LIST
    
    rm `pwd`/.wgetrc
    unset WGETRC
fi
