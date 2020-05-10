# MongoDB

Instalación de MongoDB

## Instalación

Use the package manager [pip](https://pip.pypa.io/en/stable/) to install foobar.

```bash
sudo apt update && sudo apt upgrade -y
sudo apt install mongodb
```
Chequeamos estado de la instalación.
```bash
sudo systemctl status mongodb
```

## Robo3t (IDE para mongoDB)

Descargar [Robo3t](https://robomongo.org/download)

```bash
sudo mkdir /usr/local/bin/robomongo
```
Descomprimir la carpeta y mover archivos a la carpeta creada
```bash
sudo tar -xvzf robo3t-1.3.1-linux-x86_64-7419c406.tar.gz
sudo mv robo3t-1.3.1-linux-x86_64-7419c406/* /usr/local/bin/robomongo
```
Mover al directorio actual y ejecutar robo3t

```bash
./robo3t
```

## Conexión
Crear una conexión a la base de datos. En el arbol de base de datos, crear una nueva. Dentro de la base de datos, crear una colección de datos.

## Instalación de tools

```bash
sudo apt-get install mongo-tools
```
Luego desde la terminal ejecutar:

```bash
mongoimport --db <databasename> --collection <collectionname> < pathfile.txt
```

## Querys

Query de búsqueda por ID: 

```javascript
db.getCollection('user').find({id:433})
```

Búsqueda de users que tienen como amigo al ID 433. (Con esto se podría sacar los amigos de los amigos de 433)

```javascript
db.getCollection('user').find({ friends: {$in: [433]} })
```