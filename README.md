# BD-UNLP-TP-COVID
Trabajo práctico final de la materia "Captura y Almacenamiento de la Información"

En el proyecto "Sistema de apoyo a la detección y monitoreo inteligente de personas con COVID-19" [1] del Laboratorio de Sistemas de Información Avanzados (LSIA) de la Facultad de Ingeniería de la Universidad de Buenos Aires, se desea explotar la información almacenada. 

El proyecto está en etapa de desarrollo de la aplicación móvil recolectora de información. El universo de datos recolectados contará con información de seguimiento de contactos entre personas generados por distintos mecanismos de detección de interacción social como: carga manual de DNI, proximidad por Bluetooth y Wi-fi. Estos contactos generados contarán serán enriquecidos con información temporal para poder determinar con más precisión el peligro de contagio. 

La cantidad de información almacenada será directamente propocional a la cantidad de usuarios que adepten la aplicación. Estudios epidemológicos recientes [2][3] demuetran que la aplicación de este puede ser un mecanismo de batalla contra el virus sólo si es adoptada por más del 70% de la población. La institución espera que si nuestro proyecto es adoptado, la aplicación sea probada en un conjunto de usuarios de prueba de una localidad pequeña y luego se lanzaría para un rango más amplio como la Ciudad Autónoma de Buenos Aires. 

Se necesita desarrollar un mecanismo de almacenamiento que permita explotar fácilmente los datos. El servicio debe permitir realizar de forma eficiente una serie de consultas relacionadas con la detección de contactos directos e indirectos de un paciente diagnosticado positivo de COVID-19.

Al día de hoy no existen bases de datos de "contact tracing" o seguimiento de contactos, ni contamos con datos propios para probar la arquitectura. Es por ello que se buscó una base de datos pública de contactos sociales que aproxima la tipología del grafo de contactos que se generará con la aplicación que vamos a desarrollar.  

#Set de datos elegido: Friendster

Friendster era una red social que permitía a los usuarios conectarse con sus amigos. El elemento central del sitio era la 'lista de amigos', que mostraba los contactos del usuario. Este conjunto de datos contiene las conexiones entre todos los usuarios de Friendster.

Cantidad de usuarios o nodos: ~100 millones
Cantidad de contactos o conexiones: 2.586.147.869

Descargar desde: https://archive.org/download/friendster-dataset-201107

#Método de comparación

1 - Loading time: TigerGraph 1.3x times faster than Neo4j.
2 - Storage size: TigerGraph requires 2.1x times less storage space than Neo4j.
1-step neighborhood query: TigerGraph is 8x faster than Neo4j.
3-step neighborhood query: TigerGraph is at least 900x faster than Neo4j.
6-step neighborhood query:

Se evaluarán los resultados obtenidos para 


la Base de datos NoSQL, MongoDB. Y luego se compararán los resultados con 

1 - Iniciar el servicio de neo4j

```
sudo neo4j start
```

*OJO*: Si pincha hay que revisar el log

```
cat /var/log/neo4j/neo4j.log
```

En mi caso pasaba que los puertos que usa por default estaban siendo usados y tuve que cambiarlos desde

```
/etc/neo4j/neo4j.conf
```

2 - En una de las ultimas lineas dice en que puerto levanta la UI:

```
Started neo4j (pid 13595). It is available at http://localhost:5474/
```

Abrir esa direccion



(para probar, con bajarse solamente friends-000______.txt.bz2 y descomprimirlo esta ok)

4 - En la IU ir a "Database" (en el menu de la izq)

5 - Arriba aparece una consola para ejecutar comandos, correr:

```
create index on :User(id);
```

6 - Levantar el archivo descargado (toma 1-2 min)

```
USING PERIODIC COMMIT 1000
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

[1] "Sistema de apoyo a la detección y monitoreo inteligente de personas con COVID-19" - https://lsia.github.io/COVID-19/
[2] Hellewell, J., Abbott, S., Gimma, A., Bosse, N.I., Jarvis, C.I., Russell, T.W., Munday, J.D., Kucharski, A.J., Edmunds, W.J., Sun, F., et al.: Feasibility of controlling covid-19 outbreaks by isolation of cases and contacts. The Lancet Global Health (2020)
[3] Ferretti, L., Wymant, C., Kendall, M., Zhao, L., Nurtay, A., Bonsall, D.G., Fraser, C.: Quantifying dynamics of sars-cov-2 transmission suggests that epidemic control and avoidance is feasible through instantaneous digital contact tracing. medRxiv (2020)
