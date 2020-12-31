# aforo255-microservices

El presente proyecto es creado a modo demostrativo como funciona una arquitectura de microservicios con una de eventos, 
para este último usaremos un broker de mensajería como RabbitMQ.

## 1. Pre-requisitos
* [Java 8](http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html])
* [Maven 3+](https://maven.apache.org/download.cgi])
* [RabbitMQ](https://www.rabbitmq.com/download.html)
* Docker https://www.docker.com/community-edition y Docker Compose https://docs.docker.com/compose/install/#prerequisites.

## 2. Configuración
### Parte 1. Configuración en docker
1. Crear una red: 
```
docker network create aforo255-test
```
2. Iniciar imágenes:    

RabbitMQ
```
docker run --name aforo255-rabbitmq -p 5672:5672 -p 15672:15672 -e RABBITMQ_DEFAULT_USER=admin -e RABBITMQ_DEFAULT_PASS=1234 --network aforo255-test -d rabbitmq:3-management
```
MySQL
```
docker run --name aforo255-mysql-pay -v c:/docker/aforo255-mysql:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=1234 -e MYSQL_DATABASE=db_pay --network aforo255-test -p 3308:3306 -p 33063:33060 -d mysql
```

PostgreSQL
```
docker run --name aforo255-postgres-invoice -v c:/docker/aforo255-posgresql:/var/lib/postgresql/data --network aforo255-test -p 5434:5432 -e POSTGRES_PASSWORD=123456 -e  POSTGRES_DB=db_invoice -d postgres:12-alpine​
```

Mongo
```
docker run --name aforo255-mongo-transaction -v c:/docker/aforo255-mongo:/data/db -e MONGO_INITDB_ROOT_USERNAME=adminn -e MONGO_INITDB_ROOT_PASSWORD=1234 --network aforo255-test  -d mongo
```

