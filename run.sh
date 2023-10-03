#!/bin/sh

# Variables
IMAGE_NAME="geotrellis-almond"
TAG_NAME="latest"

# Check if the image exists
IMAGE_EXISTS=$(docker images | grep $IMAGE_NAME | grep $TAG_NAME)

if [[ -z "$IMAGE_EXISTS" ]]; then
  echo "Image does not exist, building now..."
  docker build -t $IMAGE_NAME:$TAG_NAME ./docker
else
  echo "Image already exists. Skipping build."
fi

docker run --rm -it \
    -p 8888:8888 \
    -p 4040:4040 \
    -v $(pwd)/notebooks:/home/jovyan/workshop geotrellis-almond
