docker kill $(docker ps -q)  # to kill all running containers
docker rm $(docker ps -a -q) # to delete all stopped containers.
docker volume rm $(docker volume ls -q) # to delete all volumes.
docker rmi $(docker images -q) # to delete all images.
