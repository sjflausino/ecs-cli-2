
#!/bin/bash
set -e

# build image

export APP_NAME=health-check-app
export AWS_PROFILE=default
export AWS_DEFAULT_REGION=us-east-1
export AWS_ACCOUNT_ID=844606521248

docker login --username AWS --password-stdin $AWS_ACCOUNT_ID.dkr.ecr.$AWS_DEFAULT_REGION.amazonaws.com

docker build -t $APP_NAME .
docker tag $APP_NAME:latest 



# push image to ECR repo
docker push $AWS_ACCOUNT_ID.dkr.ecr.$AWS_DEFAULT_REGION.amazonaws.com/$APP_NAME:latest

