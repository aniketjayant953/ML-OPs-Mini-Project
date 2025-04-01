#!/bin/bash

# Login to AWS ECR
aws ecr get-login-password --region eu-north-1 | docker login --username AWS --password-stdin 864899871537.dkr.ecr.eu-north-1.amazonaws.com

# Pull the latest image
docker pull 864899871537.dkr.ecr.eu-north-1.amazonaws.com/emotion-project-ecr:v3

# Stop the container if it is running
if [ "$(docker ps -q -f name=campusx-app)" ]; then
    echo "Stopping container campusx-app..."
    docker stop campusx-app
else
    echo "Container campusx-app is not running."
fi

# Remove the container, whether it's stopped or not
if [ "$(docker ps -a -q -f name=campusx-app)" ]; then
    echo "Removing container campusx-app..."
    docker rm campusx-app
else
    echo "No container named campusx-app found."
fi

# Run the new container
docker run -d -p 80:5000 -e DAGSHUB_PAT=157747ed9e1f44d43b983f67bfb36c12e07602e5 --name campusx-app 864899871537.dkr.ecr.eu-north-1.amazonaws.com/emotion-project-ecr:v3