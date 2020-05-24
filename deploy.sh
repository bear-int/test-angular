#!/bin/bash

PROJECT_NAME=git-repo-manager
ZONE=us-central1-a
DOCKER_IMAGE=angular-intro
CLUSTER1=angular-intro
DATE_TIME=$(date "+%Y%m%d-%H%M%S")

# echo "docker build"
docker build -t gcr.io/$PROJECT_NAME/$DOCKER_IMAGE:$DATE_TIME .

# Connect to GCloud
echo $GCLOUD_SERVICE_KEY | base64 --decode -i > ${HOME}/gcloud-service-key.json
gcloud auth activate-service-account --key-file ${HOME}/gcloud-service-key.json

gcloud --quiet config set project $PROJECT_NAME
gcloud --quiet config set compute/zone $ZONE

# docker push
gcloud docker -- push gcr.io/$PROJECT_NAME/$DOCKER_IMAGE:$DATE_TIME
yes | gcloud beta container images add-tag gcr.io/$PROJECT_NAME/$DOCKER_IMAGE:$DATE_TIME gcr.io/$PROJECT_NAME/$DOCKER_IMAGE:latest

echo "Create instance"
 gcloud beta compute instances create-with-container instance-1 \
   --zone $ZONE_EN1B \
   --container-image=gcr.io/$PROJECT_NAME/$DOCKER_IMAGE:latest \
   --machine-type=g1-small

