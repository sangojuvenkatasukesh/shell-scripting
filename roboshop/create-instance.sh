#!bin/bash

ID="lt-01034a8f3c0dc4be2"
LVER=2
INSTANCE_NAME=$1

if [ -z "${INSTANCE_NAME}" ]; then
  echo "Input is missing"
  exit 1
fi