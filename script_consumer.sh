#!/bin/sh

response=$(curl -H "Accept:application/json" --write-out %{http_code} --silent --output /dev/null localhost:8083/)
if [ $response -eq 200 ]
then
    echo "Connector deployed with success"
else
    echo "Connector is not working"
    exit 0
fi

curl -i -X POST -H "Accept:application/json" -H "Content-Type:application/json" localhost:8083/connectors/ -d '{ "name": "test-connector", "config": { "connector.class": "io.debezium.connector.mysql.MySqlConnector", "tasks.max": "1", "database.hostname": "mysql", "database.port": "3306", "database.user": "debezium", "database.password": "dbz", "database.server.id": "184054", "database.server.name": "dbserver1", "database.whitelist": "test", "database.history.kafka.bootstrap.servers": "kafka:9092", "database.history.kafka.topic": "dbhistory.test" } }'
if [ 0 -eq $? ]
then
    echo "Succesfully sent the test mysql-connector"
else
    echo "Mysql connector did not work"
    exit 0
fi

response=$(curl -H "Accept:application/json" localhost:8083/connectors/)
if echo "${response}" | grep "test-connector"
then
    echo "Test-connector is working"
else
    echo "No connector deployed"
    exit 0
fi

docker-compose -f docker-compose.yml exec kafka /kafka/bin/kafka-console-consumer.sh \
    --bootstrap-server kafka:9092 \
    --from-beginning \
    --property print.key=true \
    --topic dbserver1.test.people
