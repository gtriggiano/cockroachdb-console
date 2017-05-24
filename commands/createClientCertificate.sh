#!/bin/bash

source "${BASH_SOURCE%/*}/common.sh"

echo 'Enter the client name:'
read -p "> " CLIENT_NAME

docker-compose run cockroachdb cert create-client \
  $CLIENT_NAME \
  --certs-dir=/certs \
  --ca-key=/certs/ca.key
