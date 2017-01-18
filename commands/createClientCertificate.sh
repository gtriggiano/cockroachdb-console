#!/bin/bash

source "${BASH_SOURCE%/*}/common.sh"

mkdir -p "$CERTS_DIR/clients"
CA_CERT="$CERTS_DIR/ca.crt"
CA_KEY="$CERTS_DIR/ca.key"
[[ ! -f "$CA_CERT" ]] && echo_exit "Could not find the ca.crt file. You can create one through: npm run create:ca:cert"
[[ ! -f "$CA_KEY" ]] && echo_exit "Could not find the ca.key file. You can create one through: npm run create:ca:cert"

echo 'Enter the client name:'
read -p "> " CLIENT_NAME

CERT_PATH="$CERTS_DIR/clients/$CLIENT_NAME.crt"
KEY_PATH="$CERTS_DIR/clients/$CLIENT_NAME.key"

[[ -f "$CERT_PATH" ]] && echo_exit "A .crt file named $CLIENT_NAME already exists in ./certs/clients/$CLIENT_NAME.crt"
[[ -f "$KEY_PATH" ]] && echo_exit "A .key file named $CLIENT_NAME already exists in ./certs/clients/$CLIENT_NAME.key"

docker run --rm -v "$CERTS_DIR:/certs" cockroachdb/cockroach:beta-20161110 cert create-client $CLIENT_NAME --ca-cert=/certs/ca.crt --ca-key=/certs/ca.key --cert=/certs/clients/$CLIENT_NAME.crt --key=/certs/clients/$CLIENT_NAME.key
