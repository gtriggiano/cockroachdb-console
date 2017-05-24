#!/bin/bash

source "${BASH_SOURCE%/*}/common.sh"

echo 'Enter the node name:'
read -p "> " NODE_NAME

echo 'Hostname(s) of node:'
read -p "> " NODE_HOSTNAMES

docker-compose run cockroachdb cert create-node \
  $NODE_NAME \
  cockroachdb \
  localhost \
  127.0.0.1 \
  $NODE_HOSTNAMES \
  --certs-dir=/certs \
  --ca-key=/certs/ca.key

mv "${BASH_SOURCE%/*}/../certs/node.crt" "${BASH_SOURCE%/*}/../certs/node.$NODE_NAME.crt"
mv "${BASH_SOURCE%/*}/../certs/node.key" "${BASH_SOURCE%/*}/../certs/node.$NODE_NAME.key"
