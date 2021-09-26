#!bin/bash

LID="lt-07a997b45f50e990a"
LVER=1
INSTANCE_NAME=$1

if [ -z "${INSTANCE_NAME}" ]; then
    echo "Input is Missing"
    exit 1
fi

InstanceID=$(aws ec2 run instances)