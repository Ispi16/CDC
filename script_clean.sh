#!/bin/sh

docker-compose -f docker-compose.yml down

wait

for i in `docker ps -a | awk '{print $1}'`
do 
	docker rm $i
done
