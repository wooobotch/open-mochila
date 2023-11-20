#openAgenda

##Otra piedra más en el camino de las distracciones
La idea de descentralizar y migrar todo a la nube, a un servidor aparte o tener en cualquier lugar menos en la herramienta de trabajo, conforme pase el tiempo, se convierte en mayores dificultades.

##El _Registro_
En el directorio _pFiles_, que puede ser cambiado de nombre, se agruparán los archivos donde se registraran _issues_. El formato puede consultarse manualmente luego de crear una nueva entrada (guiada por cierto) con el comando ´agenda -a´ en el directorio anteriormente especificado.
Los campos que conforman la entrada son:
- ID, un valor entero que se asigna automáticamente en cada registro creado.
- PROJECT, hace referencia al proyecto, pueden ser sólo palabras claves en lugar de un proyecto real.
- TITLE, es el título del registro, le hace distinto de otros aunque no es necesario que sea único.
- STATUS, es una palabra clave para identificar rápidamente detalles del estado de la actividad referida en el registro.
- ASSIGNEE, quién o quiénes intervienen en la actividad del registro.
- CREATION_DATE, fecha de creación del registro.
- DUE_DATE, fecha límite, estimada o deliberada.
- SUMMARY, resumen descriptivo del tema del registro.

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
