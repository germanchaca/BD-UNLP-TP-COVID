Trabajo práctico final de la materia "Captura y Almacenamiento de la Información", Posgrado UNLP, Marzo 2020
- Alumno: Germán Concilio. 
- Profesor: Bazzocco Javier

# Introducción
En el proyecto "Sistema de apoyo a la detección y monitoreo inteligente de personas con COVID-19" [1] del Laboratorio de Sistemas de Información Avanzados (LSIA) de la Facultad de Ingeniería de la Universidad de Buenos Aires, se desea explotar la información almacenada. 

El proyecto está en etapa de desarrollo de la aplicación móvil recolectora de información. El universo de datos recolectados contará con información de seguimiento de contactos entre personas generados por distintos mecanismos de detección de interacción social como: carga manual de DNI, proximidad por Bluetooth y Wi-fi. Estos contactos generados contarán serán enriquecidos con información temporal para poder determinar con más precisión el peligro de contagio. 

La cantidad de información almacenada será directamente propocional a la cantidad de usuarios que adepten la aplicación. Estudios epidemológicos recientes [2][3] demuetran que la aplicación de este puede ser un mecanismo de batalla contra el virus sólo si es adoptada por más del 70% de la población. La institución espera que si nuestro proyecto es adoptado, la aplicación sea probada en un conjunto de usuarios de prueba de una localidad pequeña y luego se lanzaría para un rango más amplio como la Ciudad Autónoma de Buenos Aires. 

Se necesita desarrollar un mecanismo de almacenamiento que permita explotar fácilmente los datos. El servicio debe permitir realizar de forma eficiente una serie de consultas relacionadas con la detección de contactos directos e indirectos de un paciente diagnosticado positivo de COVID-19.

Al día de hoy no existen bases de datos de "contact tracing" o seguimiento de contactos, ni contamos con datos propios para probar la arquitectura. Es por ello que se buscó una base de datos pública de contactos sociales que aproxima la tipología del grafo de contactos que se generará con la aplicación que vamos a desarrollar.  

# Set de datos elegido: Friendster

Friendster [4] era una red social que permitía a los usuarios conectarse con sus amigos. El elemento central del sitio era la 'lista de amigos', que mostraba los contactos del usuario. Este conjunto de datos contiene las conexiones entre todos los usuarios de Friendster.
La red Friendster contiene usuarios conectados entre sí a través relaciones de amistad. 

Cantidad de usuarios o nodos: ~100 millones
Cantidad de contactos o conexiones: ~2.500 millones

El tamaño del conjunto de datos es de 22.8 GB descomprimido -comprimido 10GB-.

Descargar desde: https://archive.org/download/friendster-dataset-201107

# Método de comparación entre tecnología de base de datos

1. Tiempo de carga del set de datos
2. Espacio de almacenamiento
3. Tiempo en devolver todos los contactos directos con un infectado
4. Tiempo en devolver todos los contactos indirectos de 1 salto con 1 enfectado
5. Tiempo en devolver todos los contactos indirectos de hasta 2 saltos con 1 enfectado

# Configuración del ambiente de pruebas

## Hardware

Todas las pruebas fueron realizadas en una computadora personal con las siguientes caracterísitcas:

Sistema Operativo | CPU | Memoria | Espacio en Disco | Tipo de Volumen
--- | --- | --- | --- |--- 
Windows 10 x64 | Core(TM) i7-5500U @2.40 GHz | 8.00GB DDR3| 1TB | SATA III 

## Software

1. MondoDB
2. Neo4j 4.0.3 Community Edition
3. TigerGraph 2.1.4 Developer Edition

Se evaluarán los resultados obtenidos en una base de datos NoSQL, MongoDB. Y luego se compararán los resultados con bases de datos orientadas a grafos. La base de datos orientada a grafos más popular hoy en día es Neo4j, clasificada como #1 por DB-engine. 

Evaluaremos también TigerGraph, que afirma ser la plataforma gráfica más rápida y escalable, después de lanzar su edición gratuita para desarrolladores de aplicaiones para combatir el COVID-19 [5], recientemente publicó sus resultados de referencia en Amazone Neptune. TigerGraph supera a estas bases de datos de grafos por un amplio margen en todas las pruebas de referencia. Además, TigerGraph demuestra un uso de almacenamiento más eficiente, reduciendo el tamaño de datos original en lugar de expandirlo, como es el caso de las otras bases de datos.

# Descripción de pruebas y resultados

## Carga de datos

Los métodos de carga utilizados son los siguientes:

### MongoDB

Correr Jupyter carga_friendster_mongodb.ipynb

### Neo4j

1 - Iniciar el servicio de neo4. 


2 - Ingresar al puerto donde levanta la UI:

```
Started neo4j (pid 13595). It is available at http://localhost:5474/
```

4 - En la IU ir a "Database" (en el menu de la izq)

5 - Arriba aparece una consola para ejecutar comandos, correr:

```
create index on :User(id);
```

6 - Levantar el archivo descargado

Para eso debemos combinar los .txt porque originalmente viene partido
```
C:\> copy in*.txt Combined.txt
```

```
:auto USING PERIODIC COMMIT 1000
LOAD CSV FROM "file:///friends-000______.txt" as line FIELDTERMINATOR ":"
MERGE (u1:User {id:line[0]})
;
```

Para ejecutar esto sin error tuve que agregar :auto USING PERIODIC COMMIT 1000... (Mint 19, Neo4j 4.0.3)

*OJO:* Desde la UI tuve problema para poder levantar el archivo desde cualquier carpeta  y tuve que copiarlo en 

```
/var/lib/neo4j/import
```
Se puede configurar desde el archivo config (/etc/neo4j/neo4j.conf). Hay que comentar la linea 'dbms.directories.import=import' y sacarle el comentario a la linea 'dbms.security.allow_csv_import_from_file_urls=true' para que permita importar desde cualquier lugar.

7 - Ver que se cargaron los id ok

```
MATCH (n) RETURN n LIMIT 25
```

### TigerGraph


# Referencias
- [1] "Sistema de apoyo a la detección y monitoreo inteligente de personas con COVID-19" - https://lsia.github.io/COVID-19/
- [2] Hellewell, J., Abbott, S., Gimma, A., Bosse, N.I., Jarvis, C.I., Russell, T.W., Munday, J.D., Kucharski, A.J., Edmunds, W.J., Sun, F., et al.: Feasibility of controlling covid-19 outbreaks by isolation of cases and contacts. The Lancet Global Health (2020)
- [3] Ferretti, L., Wymant, C., Kendall, M., Zhao, L., Nurtay, A., Bonsall, D.G., Fraser, C.: Quantifying dynamics of sars-cov-2 transmission suggests that epidemic control and avoidance is feasible through instantaneous digital contact tracing. medRxiv (2020)
- [4] J. Yang and J. Leskovec. Defining and Evaluating Network Communities based on Ground-truth. ICDM, 2012
- [5] https://www.tigergraph.com/stopcoronavirus/
