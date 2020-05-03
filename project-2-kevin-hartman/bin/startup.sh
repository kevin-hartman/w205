#!/bin/sh

./bin/project2-stack.sh up

docker-compose exec kafka kafka-topics --create --topic assessments --partitions 1 --replication-factor 1 --if-not-exists --zookeeper zookeeper:32181

docker-compose exec spark ln -s /w205 w205

mkdir data

curl -L -o data/assessment-attempts-20180128-121051-nested.json https://goo.gl/ME6hjp

docker-compose exec mids bash -c "cat /w205/project-2-kevin-hartman/data/assessment-attempts-20180128-121051-nested.json | jq '.[]' -c | kafkacat -P -b kafka:29092 -t assessments"

docker-compose exec spark env PYSPARK_DRIVER_PYTHON=jupyter PYSPARK_DRIVER_PYTHON_OPTS='notebook --no-browser --port 8888 --ip 0.0.0.0 --allow-root' pyspark
