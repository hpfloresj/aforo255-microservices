#!/bin/bash
source ./global-config.sh

if [ -z $(docker network ls --filter name=^${NETWORK_NAME}$ --format="{{ .Name }}") ] ; then 
     docker network create ${NETWORK_NAME}; 
fi
echo "RABBITMQ"
docker run --name $RABBITMQ_CONTAINER -p $RABBITMQ_HOST_PORT:5672 -p $RABBITMQ_WEB_PORT:15672 -e RABBITMQ_DEFAULT_USER=$RABBITMQ_DEFAULT_USER -e RABBITMQ_DEFAULT_PASS=$RABBITMQ_DEFAULT_PASS --network $NETWORK_NAME -d rabbitmq:3-management
echo "MYSQL"
docker run --name $MYSQL_CONTAINER -v $MYSQL_VOLUMEN:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=$MYSQL_ROOT_PASSWORD -e MYSQL_DATABASE=$MYSQL_DATABASE --network $NETWORK_NAME -p $MYSQL_PORT:3306 -p $MYSQL_PORT_X:33060 -d mysql
echo "POSTGRESQL"
docker run --name $POSTGRES_CONTAINER -v $POSTGRES_VOLUMEN:/var/lib/postgresql/data --network $NETWORK_NAME -p $POSTGRES_PORT:5432 -e POSTGRES_PASSWORD=$POSTGRES_PASSWORD -e POSTGRES_DB=$POSTGRES_DB -d postgres:12-alpine
echo "MONGO"
docker run --name $MONGO_CONTAINER -v $MONGO_VOLUMEN:/data/db -e MONGO_INITDB_ROOT_USERNAME=$MONGO_INITDB_ROOT_USERNAME -e MONGO_INITDB_ROOT_PASSWORD=1234 -p $MONGO_PORT:27017 --network $NETWORK_NAME -d mongo
