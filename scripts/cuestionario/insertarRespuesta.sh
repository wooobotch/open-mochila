#!/bin/bash

generarOpc(){
  read -p "Valor de la respuesta: " TIPO
  read -p "Ingrese el texto de la respuesta: " TEXTO

  RESPUESTA=$"[$TIPO]$TEXTO"
  TEMP=$(date +"%s")

  head -n $2 $1 > $TEMP
  echo $RESPUESTA >> $TEMP
  tail -n +$(( $2 + 1 )) $1 >> $TEMP
}

main(){
  while :
    do
      grep -n "^\[?]" $1
      read -p "Ingrese el número de línea de la CONSIGNA: " LINEA

      EXTREMOS=$(grep -n "^\[?]" $1 | cut -d: -f 1 | grep -A 1 $"^$LINEA" | head -n 2 | xargs -n2 | awk '{print $1 "-" $2}')
      INICIO=$(echo  $EXTREMOS | cut -d "-" -f 1)
      FIN=$(echo $EXTREMOS | cut -d "-" -f 2)
      SALTO=$(( $FIN - $INICIO ))

      FIN=$(( $FIN - 2 ))
      SALTO=$(( $SALTO - 1 ))

      head -n $FIN $1 | tail -n $SALTO
      read -p "¿Es esa la consigna a editar?" SN
      case $SN in
        S | s)
          generarOpc $1 $FIN $SALTO
          ;;
        N | n)
          read -p "Escriba 'cancelar' para no insertar más respuestas: " RESP
          case $RESP in
            C | c | cancelar | CANCELAR)
              break
              ;;
            *)
              continue
              ;;
            esac
      esac
    done
}

main $1
