#!bin/bash

LID=""
LVER=2
INSTANCE_NAME=$1

if [ -z "${INSTANCE_NAME}" ]; then
  echo "Input is missing"
  exit 1
fi