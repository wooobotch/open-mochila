#!/bin/bash
set -Eeo pipefail


##################################################################
##################################################################
#Variables globales
TEXTO="./mensajes.sh"
APUNTAR="./editor.sh"
SORTEAR="./sortear.sh"


##################################################################
##################################################################
#Función/ciclo principal
main() {
  bash $TEXTO bandera
  existeFichero $1 && describirFichero $1
  while :
    do
      echo -e $"\n> Ingrese una palabra del listado para comenzar.\n> Presione [CTRL+C] para finalizar."
      echo -e $"> Texto no listado desplegará un mensaje de ayuda.\n>>> Consultar - Imprimir - Salir\n"
      read ACCION
      case $ACCION in
        Consultar | consultar)
          read -p "Nombre o ruta del fichero a revisar: " NOMBRE
          procesarFichero $NOMBRE
          ;;
        Imprimir | imprimir | IMPRIMIR)
          echo -e $"Ingrese el nombre o ruta del fichero a imprimir."
          read -p "Nombre o ruta del fichero de referencia: " NOMBRE
          generarSorteo $NOMBRE
          ;;
        Salir | SALIR | salir | FIN | fin | Fin)
          break
          ;;
        *)
          bash $TEXTO ayuda
          ;;
      esac
    done
}

##################################################################
##################################################################
#Funciones auxiliares

################################################
existeFichero(){
  [ -f $1 ] || (echo -e $"No se encuentra el documento solicitado.\n" && return 1)
}

################################################
describirFichero(){
  echo -e $"Descripción del fichero:"
  CONSIGNAS=`grep "[?]" $1 | wc -l`
	  VF=`grep "[?]" $1 | grep "[V]" | wc -l`
  MO=`grep "[?]" $1 | grep "[M]" | wc -l`
  echo -e $"Hay $CONSIGNAS consignas:\n  > $VF son 'Verdadero o Falso'.\n  > $MO son 'Opción múltiple'."
}

################################################
editarFichero() {
  bash $TEXTO avisoEditor
  while :
  do
    bash $TEXTO opcionesEditor
    read -p "Ingrese una de las opciones listadas: " EDITAR
    case $EDITAR in
      CE | ce)
        echo -e $"Edición Finalizada."
        break
        ;;
      BC | bc | AC | ac | BR | br | AR | ar)
        bash $APUNTAR $1 $EDITAR
      *)
        ;;
    esac
  done
}

################################################
generarSorteo() {
  bash $TEXTO avisoSorteo
  while :
  do
    echo -e $"Ingrese 'SI' para generar automáticamente."
    echo -e $"Ingrese 'NO' para proceder manualmente."
    read -p "SI/NO: " SN
    case $SN in
      SI | si | s | S)
        echo -e $"Ingrese los valores solicitados a continuación."
        read -p "Ingrese la cantidad de exámenes a generar: " PAG
        [ -z $PAG ] continue
        read -p "Ingrese la cantidad máxima de consignas: " TQ
        [ -z $TQ ] continue
        read -p "Cantidad de consignas Verdadero o Falso: " VOF
        [ -z $VOF ] && MPMAX=$TQ || read -p "Cantidad consignas de opción múltiple: " MOP
        [ -z $MOP ] MPMAX=0 || read -p "Cantidad máxima de opciones: " MPMAX
        bash $SORTEAR  PAG TQ VOF MOP MPMAX
        ;;
      NO | no | n | N)
        bash $SORTEAR
        ;;
    esac
  done
}

################################################
procesarFichero(){
  existeFichero $1 && describirFichero $1 && editarFichero $1 || crearFichero $1
}

################################################
crearFichero() {
  echo -e $"¿Desea crear un documento de ejemplo con el nombre '$1'?"
  read -p "SI/NO: " SN
  case $SN in
    SI | si | s | S)
      bash $TEXTO $1
      ;;
    NO | no | n | N)
      ;;
  esac
}


##################################################################
##################################################################
#Llamado y ejecución de funciones
[ -z "$*" ] && ayuda || main $1
