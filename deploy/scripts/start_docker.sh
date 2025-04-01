#!/bin/bash

# Login to AWS ECR
aws ecr get-login-password --region eu-north-1 | docker login --username AWS --password-stdin 864899871537.dkr.ecr.eu-north-1.amazonaws.com

# Pull the latest image
docker pull 864899871537.dkr.ecr.eu-north-1.amazonaws.com/emotion-project-ecr:v3

# Check if the container  'campusx-app' is running
if ["$(docker ps -q -f name=campusx-app)"]; then
    # Stop the container
    docker stop campusx-app 

# Check if the container 'campusx-app' exists (stopped or running)
fi ["$(docker ps -q -f name=campusx-app)"]; then
    # Remove the container if it exists
    docker rm campusx-app 


# Run the new container
docker run -d -p 80:5000 -e DAGSHUB_PAT=157747ed9e1f44d43b983f67bfb36c12e07602e5 --name campusx-app 864899871537.dkr.ecr.eu-north-1.amazonaws.com/emotion-project-ecr:v3