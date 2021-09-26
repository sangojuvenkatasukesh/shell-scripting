#!bin/bash

LID=""
LVER=2
INSTANCE_NAME=$1

if [ -z "${INSTANCE_NAME}" ]; then
  echo "Input is missing"
  exit 1
fi
P=$(aws ec2 run-instances --launch-template LaunchTemplateId=$LID,Version=$LVER --tag-specifications "ResourceType=spot-instances-request,Tags=[{Key=Name,Value=$INSTANCE_NAME}]" "ResourceType=instance,Tags=[{Key=Name,Value=$INSTANCE_NAME}]" | jq .Instances[].PrivateIpAddress | sed -e 's/"//g')

sed -e "s/INSTANCE_NAME/$INSTANCE_NAME/" -e "s/INSTANCE_IP/$IP/" record.json >/tmp/record.json
aws route53 change-resource-record-sets --hosted-zone-id Z06421191721I0AOBUGO2 --change-batch file:///tmp/record.json | jq
