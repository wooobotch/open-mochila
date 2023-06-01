#!/usr/bin/env bash

EDITOR="nano"
PFILES="pFiles"
PWD=$( cd -- "$(dirname "$0")" >/dev/null 2>&1 && pwd -P )/$PFILES

AYUDA="AGENDA\nLa presente herramienta consta de generación y control de
plantillas de registros.\nPara 'instalar' ejecute el script 'instalar.sh' y
siga las instrucciones.\nLos registros son creados con campos por defecto (ID,
PROJECT, TITLE, STATUS, ASSIGNEE, CREATION_DATE, DUE_DATE, SUMMARY)\npero
pueden añadirse o cambiarse detalles en con cualquier editor
de texto.\nLos registros se encuentran en el directorio $PFILES.\n\n
-a\tInicia la creación de un nuevo registro.\n
-o\tLista los registros con estado abierto (STATUS open).\n
-n\tInserta un comentario a un registro existente.\n
-c\tLista los comentarios o notas en un registro dado.\n
-r\tElimina un registro existente.\n
-b\tLista los registros con estado bloqueado (STATUS blocked).\n
-p\tLista los nombres proyectos a asociados a los registros existentes(campo PROJECT).\n
-m\tAbre un registro con un editor de textos.\n
-l\tLista todos los registros con un resumen de información para cada caso.\n"

getLabel(){
	grep $3 $1 $2 | cut -d " " -f 2
}

issueID2Path(){
	read -r -p "# Ingrese el ID del registro: " ID
	grep -r "ID $ID" $PWD | cut -d ":" -f 1
}

# -n
addNote(){
	echo "### Comentar un registro:"	
	listIssues
	NOTA=$(issueID2Path)
	
	while
		echo -e "# Ingrese una nota de hasta 75 caracteres:"
		read -r -p "> " INPUT
		[ ${#INPUT} -gt 75 ]
	do true; done

	echo -e "NOTE $INPUT" >> $NOTA
	echo -e "# Registro ID:$ID actualizado.\n"
}

# -c
printNotes(){
	listIssues
	REG=$(issueID2Path)
	listIssueX ID $(grep ID $REG | cut -d " " -f 2)
	grep NOTE $REG | cut -d " " -f 2-
}

# -a
newIssue(){
	echo "### Nuevo registro"
	while
		read -r -p "# TITULO NUEVO: " TITLE
		[ -f $PWD/$TITLE ]
	do true; done
	ID=$(getLabel ID $PWD -r | awk 'BEGIN{a=   0}{if ($1>0+a) a=$1} END{print (a+1)}')
	echo -e "# Ingrese los valores solicitados:"
	LP=($(getLabel PROJ $PWD -r | uniq))
	echo -e $"> Proyectos existentes:\n${LP[@]}"
	read -r -p "> PORYECTO: " PROJECT
	read -r -p "> STATUS: " STATUS
	read -r -p "> RESPONSABLE: " ASSIGNEE
	cat > $PWD/$TITLE << EOF
ID $ID
PROJECT $PROJECT
TITLE $TITLE
STATUS $STATUS
ASSIGNEE $ASSIGNEE
CREATION_DATE
DUE_DATE
SUMMARY
EOF
}

# -r
removeIssue(){
	LISTAR=""
	echo -e "# Presione enter/intro para continuar sin verificar el listado.\n# Presione cualquier tecla para listar todos los registros."
	read -r -p "> " LISTAR
	[ ! -z $LISTAR ] && listIssues
        read -r -p "Ingrese el ID del registro a eliminar: " ID
	$( grep -r "ID $ID" $PWD | cut -d ":" -f 1 | xargs rm ) || echo -e "# No se pudo eliminar el registro."
}

# -o -b
listIssueX(){
	FILES=$(grep -r $1 $PWD | grep -i $2 | cut -d ":" -f 1 | awk -F "/" '{print $NF}')
	echo -e $"\n### Issues - $1: $2"
	for ITEM in ${FILES[@]}
	do
		H0=$(getLabel ID $PWD/$ITEM)
		H1=$(getLabel TITLE $PWD/$ITEM)
		H2=$(getLabel PROJECT $PWD/$ITEM)
		H3=$(getLabel ASSIGNEE $PWD/$ITEM)
		echo -e ">  ID: $H0\tTítulo: $H1\t Proyecto: $H2\tResponsable: $H3"
	done
}

# -p
listProjects(){
	echo -e "\n### Proyectos:"
	getLabel PROJ $PWD -r | uniq
}

# -l
listIssues(){
	FILES=$(ls $PWD)
	for REG in ${FILES[@]}
	do
		H0=$(getLabel ID $PWD/$REG)
		H1=$(getLabel PROJECT $PWD/$REG)
		H2=$(getLabel TITLE $PWD/$REG)
		H3=$(getLabel STATUS $PWD/$REG)
		echo -e ">  ID: $H0\tProyecto: $H1\tIssue: $H2\tSTATUS: $H3"
	done
}

# -m
manualEditor(){
	listIssues
        REG=$(issueID2Path)
	bash -c $"$EDITOR $REG"
}

#MAIN
case $1 in
	-a | anotar | agendar)
		newIssue
		;;
	-n | comentario | comentar)
		addNote
		;;
	-c | notas)
		printNotes
		;;
	-r | remove | borrar)
		removeIssue
		;;
	-o | open)
                listIssueX STATUS open
                ;;
        -b | blocked | block)
                listIssueX STATUS blocked
                ;;
        -p | proyecto)
                listProjects 
                ;;
	-l | lista)
		listIssues
		;;
	-m | editor)
		manualEditor
		;;
	*)
		echo -e $AYUDA
		;;
esac
