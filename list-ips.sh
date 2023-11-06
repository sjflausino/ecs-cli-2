#!/bin/bash

CLUSTER_NAME="ecs-clusterx"
SERVICE_NAME=$(./list-services.sh)

aws ecs list-tasks --cluster $CLUSTER_NAME --service-name $SERVICE_NAME \
  --query 'taskArns[]' --output text | \
  xargs -I {} aws ecs describe-tasks --cluster $CLUSTER_NAME --tasks {} \
  --query 'tasks[].attachments[].details[] | [?name==`networkInterfaceId`].value' --output text | \
  xargs -I {} aws ec2 describe-network-interfaces --network-interface-ids {} \
  --query 'NetworkInterfaces[].Association.PublicIp' --output text --no-paginate

  