#!bin/bash

LID="lt-07a997b45f50e990a"
LVER=1

aws ec2 run-instances --launch-template LaunchTemplateId=$LID,Version=$LVER --tag-specifications  "ResourceType= spot-instances-request,Tags=[{Key=string,Value=string},{Key=string,Value=string}]"| jq .Instances[].InstanceId