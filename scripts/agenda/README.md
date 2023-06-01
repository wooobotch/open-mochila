#openAgenda

##Otra piedra más en el camino de las distracciones
La idea de descentralizar y migrar todo a la nube, a un servidor aparte o tener en cualquier lugar menos en la herramienta de trabajo, conforme pase el tiempo, se convierte en mayores dificultades.

##El _Registro_

##Requerimientos

##Uso
La presente herramienta consta de generación y control de plantillas de registros. Para 'instalar' ejecute el script 'instalar.sh' y
siga las instrucciones. Los registros son creados con campos por defecto (ID, PROJECT, TITLE, STATUS, ASSIGNEE, CREATION_DATE, DUE_DATE, SUMMARY)pero
pueden añadirse o cambiarse detalles en con cualquier editor de texto. Los registros se encuentran en el directorio definido en la variable <PFILES>.
-\-a Inicia la creación de un nuevo registro.
-\-o Lista los registros con estado abierto (STATUS open).
-\-n Inserta un comentario a un registro existente.
-\-c Lista los comentarios o notas en un registro dado.
-\-r Elimina un registro existente.
-\-b Lista los registros con estado bloqueado (STATUS blocked).
-\-p Lista los nombres proyectos a asociados a los registros existentes(campo PROJECT).
-\-m Abre un registro con un editor de textos.
-\-l Lista todos los registros con un resumen de información para cada caso.
