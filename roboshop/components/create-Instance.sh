#!bin/bash

LID="lt-07a997b45f50e990a"
LVER=1
INSTANCE_NAME=$1
if [ -z "${INSTANCE_NAME}" ]; then
  echo "Input is missing"
  exit 1
fi
InstanceID=$(aws ec2 run-instances --launch-template LaunchTemplateId=$LID,Version=$LVER --tag-specifications "ResourceType=spot-instances-request,Tags=[{Key=Name,Value=$INSTANCE_NAME}]" "ResourceType=instance,Tags=[{Key=Name,Value=$INSTANCE_NAME}]" | jq .Instances[].PrivateIpAddress | sed -e 's/"//g')

