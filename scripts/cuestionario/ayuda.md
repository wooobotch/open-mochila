El presente script toma de un documento bloques de texto (presentes como renglones) que son procesados para generar una sucesión de preguntas o consignas con sus posibles respuestas.

La salida del mismo puede conservarse como markdown para ser convertido en pdf e impreso si así fuera necesario.

Para mantener la simplicidad no se utilizarán bases de datos sino texto plano de manera que pudiera utilizarse cualquier fuente para su comunicación (como por ejemplo, correo electrónico).

###Requerimientos
- bash
- grep
- read
- touch
- head
- cat
- tail
- awk
- https://github.com/mity/md4c
