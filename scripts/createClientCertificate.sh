#!/bin/bash

echo_fail() {
  echo $1
  exit 1
}

echo 'Nome utente:'
read -p "> " USER_NAME

SCRIPT_DIR=$(dirname "$0")
mkdir -p "$SCRIPT_DIR/../certs/users"
CERT_PATH="$SCRIPT_DIR/../certs/users/$USER_NAME.crt"
KEY_PATH="$SCRIPT_DIR/../certs/users/$NODE_NAME.key"

[[ -f "$CERT_PATH" ]] && echo_fail "Esiste già un certificato per l'utente"
[[ -f "$KEY_PATH" ]] && echo_fail "Esiste già un certificato per l'utente"

docker-compose run cockroach cert create-client $USER_NAME --ca-cert=/certs/ca.crt --ca-key=/certs/ca.key --cert=/certs/users/$USER_NAME.crt --key=/certs/users/$USER_NAME.key
