POC CDC - doc

The documentation for this: confluent and debezium oficial pages + https://blog.clairvoyantsoft.com/mysql-cdc-with-apache-kafka-and-debezium-3d45c00762e4
For this to work the os must have: curl, docker and docker-compose. I created a database test with a table people and 4 insert statements. The script consumer will show the change in the database. For more tests we can use the script_mysql utility that connects to mysql and we can do more operations.
After that there are 4 utilities here to test:
1) script_compose.sh -> starts the setup
2) script_consumer.sh -> deploy the connector and show the results
3) script_mysql.sh -> open up a mysql connection and test more the solution
4) script_clean.sh -> clean all the setup + containers (!! it deletes all containers on the running OS)
