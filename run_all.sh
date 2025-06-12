#!/bin/bash

echo "Start running the Containers"

# Create the Docker network if it doesn't exist
docker network inspect projekt-netzwerk >/dev/null 2>&1 || docker network create projekt-netzwerk

cd "./jira"
docker compose up -d

cd "../mediawiki"
docker compose up -d

cd "../monitoring(portainer)"
docker compose up -d

cd "../wordpress"
docker compose up -d

echo "All Containers are running"
