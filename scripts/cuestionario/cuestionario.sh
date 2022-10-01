#!/bin/bash

set -Eeo pipefail

##################################################################
##################################################################
#Función/ciclo principal
main () {
  bandera
  [ ! -z $1 ] && nombreFichero $1
  while :
    do
      echo -e "\nPress [CTRL+C] to stop.."
      read ACCION
      case $ACCION in
        Imprimir | imprimir | IMPRIMIR)
          cat cuestionario.md
          ;;
        Salir | SALIR | salir | FIN | fin | Fin)
          break
          ;;
        *)
          nombreFichero $ACCION
          ;;
      esac
    done
}

##################################################################
##################################################################
#Funciones auxiliares

nombreFichero (){
  echo -e $"Revisando nombre.\n"
  CABEZA=`echo $1 | cut -c1-2 -`
  case $CABEZA in
    /*)
      echo -e $"$CABEZA\n"
      ;;
    ./)
      echo -e $"$CABEZA\n"
      ;;
    *)
      echo -e $"$CABEZA\n"
      ;;
  esac
}


##################################################################
##################################################################
#Ayuda y texto complementario
ayuda () {
  echo -e $"Comentarios de ayuda.\n"
}

bandera () {
  echo -e $"
  ////////////\t\t\t\t*****************************************\t\t\t\t////////////\n
  ////////////\t\t\t\t****         The Open-Mochila        ****\t\t\t\t////////////\n
  ////////////\t\t\t\t****            Preguntero           ****\t\t\t\t////////////\n
  ////////////\t\t\t\t****           Edición CLI           ****\t\t\t\t////////////\n
  ////////////\t\t\t\t*****************************************\t\t\t\t////////////\n"
}

##################################################################
##################################################################
#Llamado y ejecución de funciones
[ -z "$*" ] && ayuda || main $1
