#!bin/bash

LID="lt-07a997b45f50e990a"
LVER=1
INSTANCE_NA

aws ec2 run-instances --launch-template LaunchTemplateId=$LID,Version=$LVER --tag-specifications  "ResourceType= spot-instances-request,Tags=[{Key=Name,Value=string}]"| jq .Instances[].InstanceId