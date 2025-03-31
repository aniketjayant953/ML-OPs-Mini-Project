#!/bin/bash
# Login to AWS ECR
aws ecr get-login-password --region eu-north-1 | docker login --username AWS --password-stdin 864899871537.dkr.ecr.eu-north-1.amazonaws.com
docker pull 864899871537.dkr.ecr.eu-north-1.amazonaws.com/emotion-project-ecr:v2
sudo docker stop campusx-app || true
sudo docker rm campusx-app || true
docker run -p 80:5000 -e DAGSHUB_PAT=157747ed9e1f44d43b983f67bfb36c12e07602e5 --name campusx-app 864899871537.dkr.ecr.eu-north-1.amazonaws.com/emotion-project-ecr:v2