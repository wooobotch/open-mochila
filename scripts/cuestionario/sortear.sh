#!/usr/bin/env bash

selecConsigna() {
  TOTAL=$(grep -n "^\[?]" $3 | wc -l)

  for PAGINAS in { 1..$(( $1 - 1 )) }
  do
    FILE=TEMA$(date +"%s")
    touch $FILE

    [ $TOTAL -gt $2 ] && CONSIGNAS=($(grep -n "^\[?]" $3 | cut -d :  -f 1 | sort -R | head -n $2)) || CONSIGNAS=($(grep -n "^\[?]" $3 | cut -d :  -f 1 | sort -R))

    for CONSIGNA in ${CONSIGNAS[@]}
    do
      printer $1 $CONSIGNA $FILE
    done
  done

}

printer(){
  EXTREMOS=$(grep -n "^\[?]" $1 | cut -d: -f 1 | grep -A 1 $2 | head -n 2 | xargs -n2 | awk '{print $1 "-" $2}')
  INICIO=$(echo  $EXTREMOS | cut -d "-" -f 1)
  FIN=$(echo $EXTREMOS | cut -d "-" -f 2)
  [ -z $FIN ] && FIN=$( wc -l $1 | cut -d" " -f1 ) && FIN=$(( $FIN + 1 ))
  SALTO=$(( $FIN - $INICIO - 1))

  FIN=$(( $FIN - 1 ))
  SALTO=$(( $SALTO + 1 ))

  head -n $FIN $1 | tail -n $SALTO >> $3
}

main (){
  #$1 paginas a generar (para el loop for externo)
  #$2 Cantidad máxima de consignas (para el loop interno)
}

[ -z "$*" ] && bash $TEXTO ayuda || main $1 $2
