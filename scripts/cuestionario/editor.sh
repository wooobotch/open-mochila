#!/bin/bash
set -Eeo pipefail

##################################################################
##################################################################
#Variables globales
TEXTO="./mensajes.sh"

##################################################################
##################################################################
#Funciones

##################################################################
borrarConsigna() {
  grep -n "^\[?]" $1
  read -p "Ingrese el número de línea de la consigna: " LINEA

  EXTREMOS=$(grep -n "^\[?]" modelo.abry | cut -d: -f 1 | grep -A 1 $"^$LINEA" | head -n 2 | xargs -n2 | awk '{print $1 "-" $2}')
  INICIO=$(echo  $EXTREMOS | cut -d "-" -f 1)
  FIN=$(echo $EXTREMOS | cut -d "-" -f 2)

  CAPO=$(( $INICIO - 1 ))
  LINEASTOTAL=$(wc -l $1 | awk '{print $1}')
  RABO=$(( $LINEASTOTAL - $FIN + 1 ))

  echo $"$CAPO $LINEASTOTAL $RABO"

  FILE=$(date +"%s")
  > $FILE
  head -n $CAPO $1 >> $FILE
  tail -n $RABO $1 >> $FILE
  mv $FILE $1
}

##################################################################
borrarRespuesta() {
  #Simil seleccion anterior
  #enumero las respuestas de la selección, map de awk
  #awk todo menos la línea de la respuesta
  echo "HOLA"
}

##################################################################
agregarConsigna() {
  echo "HOLA"
#Tipo
#cantidad inicial de resp
#texto consigna
#cat
#agregar respuesta $POSIC_CONSIGNA
}

##################################################################
agregarRespuesta() {
  echo "HOLA"
#si no hay cantidad inicial iterar hasta recibir empty o algo así
#iterar hasta cantidad inicial: V o F y texto
#cat
}

##################################################################
##################################################################
#Función principal
main() {
  case $2 in
    BC | bc)
      borrarConsigna $1
      ;;
    BR | br)
      borrarRespuesta $1
      ;;
    AC | ac)
      agregarConsigna $1
      ;;
    AR | ar)
      agregarRespuesta $1
      ;;
  esac
}


##################################################################
##################################################################
#Llamado y ejecución de funciones
main $1 $2
