# remove all exited containers
docker-rm-containers() {
  docker ps -a | awk '{print $1}' | while read container; do docker rm -f $container; done
}

# remove all images
docker-rm-images() {
  docker images | awk '{print $3}' | while read image; do docker rmi -f $image; done
}

# do both of the above
docker-rm-all() {
  docker-rm-containers
  docker-rm-images
}
