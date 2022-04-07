#!/bin/bash

REGION="eu-central-1"
USERNAME="AWS"
REGISTRY=""

# {case statement, regarding ecr name, infromation output}
echo "1 - for deploy to prod, 2 - for deploy to dev"
read INPUT

case $INPUT in
  1)
    REGISTRY="251865263936.dkr.ecr.eu-central-1.amazonaws.com/app-prod"
    POSTFIX="app-prod"
    ;;
  2)
    REGISTRY="251865263936.dkr.ecr.eu-central-1.amazonaws.com/app-dev"
    POSTFIX="app-dev"
    ;;
  *)
    echo "Wrong input. Try again..."
    ;;
esac

sudo aws ecr get-login-password --region $REGION | sudo docker login --username $USERNAME --password-stdin $REGISTRY
sudo docker build -t $POSTFIX ./app/app/.
sudo docker tag $POSTFIX:latest 251865263936.dkr.ecr.eu-central-1.amazonaws.com/$POSTFIX:latest
sudo docker push $REGISTRY:latest

exit 0


