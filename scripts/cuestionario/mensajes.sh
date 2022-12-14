#!/usr/bin/env bash

set -Eeo pipefail

##################################################################
##################################################################
#Ayuda y texto complementario

ayuda() {
  echo -e $"Comentarios de ayuda.\n"
}

avisoSorteo() {
  echo -e $"Comentarios de ayuda.\n"
}

opcionesEditor() {
  echo -e $"\n> BC para eliminar una consigna.\n> BR para eliminar una respuesta de una consigna."
  echo -e $"> AC para añadir una nueva consigna.\n> AR para añadir una nueva respuesta a una consigna."
  echo -e $"> CE para finalizar la edición."
}

avisoEditor() {
  echo -e $"Se recomienda utilizar un editor de textos externo,\npor ejemplo vim o emacs.\n"
}

crearFichero() {
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

case $1 in
  ayuda)
    ayuda
    ;;
  bandera)
    bandera
    ;;
  avisoSorteo)
    avisoSorteo
    ;;
  opcionesEditor)
    opcionesEditor
    ;;
  avisoEditor)
    avisoEditor
    ;;
  ficheroNuevo)
    [ "$#" -eq 2 ] && crearFichero $2 || echo -e $"No se ha podido proceder con la creación.\nDebe ingresar un nombre para el archivo."
    ;;
esac
