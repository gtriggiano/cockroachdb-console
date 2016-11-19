#!/bin/bash

echo_fail() {
  echo $1
  exit 1
}

echo 'Nome del nodo:'
read -p "> " NODE_NAME

SCRIPT_DIR=$(dirname "$0")
mkdir -p "$SCRIPT_DIR/../certs/nodes"
CERT_PATH="$SCRIPT_DIR/../certs/nodes/$NODE_NAME.crt"
KEY_PATH="$SCRIPT_DIR/../certs/nodes/$NODE_NAME.key"

[[ -f "$CERT_PATH" ]] && echo_fail "Esiste già un certificato per il nodo"
[[ -f "$KEY_PATH" ]] && echo_fail "Esiste già un certificato per il nodo"

echo 'Hostname(s) del nodo:'
read -p "> " NODE_HOSTNAME

docker-compose run cockroach cert create-node $NODE_HOSTNAME --ca-cert=/certs/ca.crt --ca-key=/certs/ca.key --cert="/certs/nodes/$NODE_NAME.crt" --key="/certs/nodes/$NODE_NAME.key"
