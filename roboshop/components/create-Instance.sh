#!bin/bash

LID=""
LVER=1

aws ec2 run-instances --launch template LaunchTemplateId=$LID,Version=$LVER