#!/bin/bash

CLUSTER_NAME="ecs-clusterx"
TASK_DEFINITION="frontend"

# List all services in the cluster
SERVICE_ARNS=$(aws ecs list-services --cluster "$CLUSTER_NAME" --query "serviceArns[]" --output text)

# Describe services and filter by task definition
for service_arn in $SERVICE_ARNS; do
    SERVICE_NAME=$(echo $service_arn | awk -F/ '{print $NF}')
    TASK_DEF=$(aws ecs describe-services --cluster "$CLUSTER_NAME" --services "$SERVICE_NAME" --query "services[0].taskDefinition" --output text)

    if [[ "$TASK_DEF" == *"$TASK_DEFINITION"* ]]; then
        #echo "Service using the task definition ($TASK_DEFINITION): $SERVICE_NAME"
        echo "$SERVICE_NAME"
    fi
done

