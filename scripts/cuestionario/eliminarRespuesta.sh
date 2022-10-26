#!/bin/bash

borrar() {
  [ $# -lt 2 ] && return
  echo "MENSAJE"
  read -p "Confirmar Si/NO" CONFIRMAR
  case $CONFIRMAR in
    S | s | SI | si | Si)
      echo "MENSAJE"
      sed -n $2 $1
#Si no tenemos GNU sed
#      TEMP=$(date +"%s")
#      sed $"$2d" $1 > $TEMP && mv $TEMP $1
      sed -i $"$2d" $1
      ;;
    N | n | NO | no | No)
      echo "NO BORRADO"
      ;;
  esac
}


ronda(){
  FIN=$2
  SALTO=$3

  grep -n "" $1 | head -n $FIN | tail -n $SALTO
  read -p "Ingrese el número de línea de la RESPUESTA: " LINEA
  borrar $1 $LINEA
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
          ronda $1 $FIN $SALTO
          ;;
        N | n)
          read -p "Escriba 'cancelar' para no eliminar más respuestas: " RESP
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
