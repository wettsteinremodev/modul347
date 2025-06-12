#!/bin/bash

echo "Start running the Containers"

# Create the Docker network if it doesn't exist
docker network inspect projekt-netzwerk >/dev/null 2>&1 || docker network create projekt-netzwerk

cd jira
docker compose up -d
cd ..

echo "Jira DONE"


cd mediawiki
docker compose up -d
cd ..

echo "Media-Wiki DONE"

cd monitoring_portainer
docker compose up -d
cd ..

echo "Portainer DONE"

cd wordpress
docker compose up -d
cd ..

echo "Wordpress DONE"
echo "All Containers are running"
