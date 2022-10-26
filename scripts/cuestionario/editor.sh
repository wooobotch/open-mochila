#!/bin/bash
set -Eeo pipefaily

##################################################################
##################################################################
#Variables globales
TEXTO="./mensajes.sh"
BORRAR="./eliminarRespuesta.sh"
INSRESP="./insertarRespuesta.sh"

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
  bash $BORRAR $1
}

##################################################################
agregarConsigna() {
  FILE=$(date +"%s")
  CONSIGNA="[?]"
  read -p "Tipo de consigna: " TIPO
  case TIPO in
    1)
      CONSINGA=$"$CONSINGNA[VF]"
      ;;
    2)
      CONSINGA=$"$CONSINGNA[MO]"
      ;;
  esac

  read -p "Ingrese el contenido de la consigna: " TEXTO
  CONSIGNA=$"CONSIGNA$TEXTO"
  echo -e $"\nSe agregará al final del listado:\n$CONSIGNA\n"

}

##################################################################
agregarRespuesta() {
  bash $INSRESP $1
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
