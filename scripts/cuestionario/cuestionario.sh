#!/bin/bash

set -Eeo pipefail

##################################################################
##################################################################
#Función/ciclo principal
main() {
  bandera
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
          ayuda
          ;;
      esac
    done
}

##################################################################
##################################################################
#Funciones auxiliares

existeFichero(){
  [ -f $1 ] || (echo -e $"No se encuentra el documento solicitado.\n" && return 1)
}

describirFichero(){
  echo -e $"Descripción del fichero:"
  CONSIGNAS=`grep "[?]" $1 | wc -l`
  VF=`grep "[?]" $1 | grep "[V]" | wc -l`
  MO=`grep "[?]" $1 | grep "[M]" | wc -l`
  echo -e $"Hay $CONSIGNAS consignas:\n  > $VF son 'Verdadero o Falso'.\n  > $MO son 'Opción múltiple'."
}

editarFichero() {
  avisoEditor
  while :
  do
    echo -e $"\n> BC para eliminar una consigna.\n> BR para eliminar una respuesta de una consigna."
    echo -e $"> AC para añadir una nueva consigna.\n> AR para añadir una nueva respuesta a una consigna."
    echo -e $"> CE para finalizar la edición."
    read -p "Ingrese una de las opciones listadas: " EDITAR
    case $EDITAR in
      CE | ce)
        echo -e $"Edición Finalizada."
        break
        ;;
      BC | bc | AC | ac | BR | br | AR | ar)
        bash ./editar.sh $1 $EDITAR
      *)
        ;;
    esac
  done
}

generarSorteo() {
  avisoSorteo
  while :
  do
    echo -e $"\n> BC para eliminar una consigna.\n> BR para eliminar una respuesta de una consigna."
    echo -e $"> AC para añadir una nueva consigna.\n> AR para añadir una nueva respuesta a una consigna."
    echo -e $"> CE para finalizar la edición."
    read -p "Ingrese una de las opciones listadas: " EDITAR
    case $EDITAR in
      CE | ce)
        echo -e $"Edición Finalizada."
        break
        ;;
      BC | bc | AC | ac | BR | br | AR | ar)
        bash ./editar.sh $1 $EDITAR
      *)
        ;;
    esac
  done
}

###FUNCION BASE
#editarFichero() {
#  avisoEditor
#  while :
#  do
#    echo -e $"\n> BC para eliminar una consigna.\n> BR para eliminar una respuesta de una consigna."
#    echo -e $"> AC para añadir una nueva consigna.\n> AR para añadir una nueva respuesta a una consigna."
#    echo -e $"> CE para finalizar la edición."
#    read -p "Ingrese una de las opciones listadas: " EDITAR
#    case $EDITAR in
#      BC | bc)
#        echo -e $"Se procederá a eliminar una consigna con todas sus respuestas."
#        ;;
#      BR | br)
#        echo -e $"Se procederá a eliminar una respuesta de una consigna específica."
#        ;;
#      AC | ac)
#        echo -e $"Se procederá a añadir una nueva consigna."
#        ;;
#      AR | ar)
#       echo -e $"Se procederá a añadir una nueva respuesta a una consigna específica."
#        ;;
#      CE | ce)
#        echo -e $"Edición Finalizada."
#        break
#        ;;
#    esac
#  done
#}
################################################

procesarFichero(){
  existeFichero $1 && describirFichero $1 && editarFichero $1 || crearFichero $1
}

##################################################################
##################################################################
#Ayuda y texto complementario
ayuda() {
  echo -e $"Comentarios de ayuda.\n"
}

avisoSorteo() {
  echo -e $"Comentarios de ayuda.\n"
}

avisoEditor() {
  echo -e $"Se recomienda utilizar un editor de textos externo,\npor ejemplo vim o emacs.\n"
}

crearFichero() {
  echo -e $"¿Desea crear un documento de ejemplo con el nombre '$1'?"
  read -p "SI/NO: " SN
  case $SN in
    SI | si | s | S)
      touch $1
      cat << 'EOF' > $1
Documento de ejemplo
[?][VF]Una consigna debe contener [?] al comienzo.
[V]Una letra "V" mayúscula entre corchetes para señalar una respuesta correcta.
[F]Una letra "F" mayúscula entre corchetes para señalar una respuesta incorrecta.

[?][MO]Si por ejemplo queremos una consigna de opción múltiple:
[V]Podemos listar todas respuestas que consideremos necesarias.
[F]No podrán agregarse posteriormente.
[F]Siempre y para todo se necesita internet y más todavía se necesita javascript.
[V]El valor de verdad se señala igual que en el verdadero o falso con [V] y con [F]
[V]Se señala con [?][VF] una consigna de opción múltiple, con [?][VF] una de verdadero o falso.
EOF
      echo -e $"\nSe ha creado un documento de ejemplo con el nombre provisto: $1"
      ;;
    NO | no | n | N)
      ;;
  esac
}

bandera() {
  echo -e $"
////////////\t\t\t\t\t*****************************************\t\t\t\t\t////////////
////////////\t\t\t\t\t****         The Open-Mochila        ****\t\t\t\t\t////////////
////////////\t\t\t\t\t****            Preguntero           ****\t\t\t\t\t////////////
////////////\t\t\t\t\t****           Edición CLI           ****\t\t\t\t\t////////////
////////////\t\t\t\t\t*****************************************\t\t\t\t\t////////////\n"
}

##################################################################
##################################################################
#Llamado y ejecución de funciones
[ -z "$*" ] && ayuda || main $1
