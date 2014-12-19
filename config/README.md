#Configuración de las fuentes de datos del portal de transparencia

El flujo de trabajo tiene que comenzar a partir de config.csv:

1. Se lee nombre de la fuente
2. Se comprueba el último momento que se ha actualizado. Si excede la periodicidad, se vuelve a pedir.
3. Se extrae del URI de origen.
4. Se procesa con el script.
5. Se sube al URI de CKAN.

Explicación de los datos


Dato | URI CKAN | URI origen | Método extracción | Script Procesamiento | Periodicidad |
---- | -------- | ---------- | ----------------- | -------------------- | ------------ |
Descripción del dato y número del mismo en la hoja de fuentes de datos en la UGR. | URI en opendata.ugr.es | De dónde se extrae o email o teléfono de la persona a la que se pide. Si se puede extraer de una BD a la que tengamos acceso, URI de la misma | Cómo se extrae, que puede ser: solicitud, scraping, db | Programa en perl para hacer scraping, procesamiento de PDF o query de la BD para extraerlo. En general, script de este repositorio donde esté | Cada cuantos días hay que pedirlo | 
