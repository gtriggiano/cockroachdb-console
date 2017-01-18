#!/bin/bash

source "${BASH_SOURCE%/*}/common.sh"

CA_CERT="$CERTS_DIR/ca.crt"
CA_KEY="$CERTS_DIR/ca.key"
[[ ! -f "$CA_CERT" ]] && echo_exit "Could not find the ca.crt file. You can create one through: npm run create:ca:cert"
[[ ! -f "$CA_KEY" ]] && echo_exit "Could not find the ca.key file. You can create one through: npm run create:ca:cert"

echo 'Enter the db host:'
read -p "> " DB_HOST

echo 'Enter the username:'
read -p "> " USERNAME

CERT_PATH="$CERTS_DIR/clients/$USERNAME.crt"
KEY_PATH="$CERTS_DIR/clients/$USERNAME.key"

[[ ! -f "$CERT_PATH" ]] && echo_exit "Could not find the $USERNAME.crt file. You can create one through: npm run create:client:cert"
[[ ! -f "$KEY_PATH" ]] && echo_exit "Could not find the $USERNAME.key file. You can create one through: npm run create:client:cert"

docker \
  run \
  -it \
  --rm \
  -v "$CERTS_DIR:/certs" \
  cockroachdb/cockroach:beta-20161110 sql $CLIENT_NAME --ca-cert=/certs/ca.crt --cert=/certs/clients/$USERNAME.crt --key=/certs/clients/$USERNAME.key --host=$DB_HOST --user=$USERNAME
