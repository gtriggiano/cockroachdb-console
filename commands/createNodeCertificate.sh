#!/bin/bash

source "${BASH_SOURCE%/*}/common.sh"

mkdir -p "$CERTS_DIR/nodes"
CA_CERT="$CERTS_DIR/ca.crt"
CA_KEY="$CERTS_DIR/ca.key"
[[ ! -f "$CA_CERT" ]] && echo_exit "Could not find the ca.crt file. You can create one through: npm run create:ca:cert"
[[ ! -f "$CA_KEY" ]] && echo_exit "Could not find the ca.key file. You can create one through: npm run create:ca:cert"

echo 'Enter the certificate name:'
read -p "> " CERT_NAME

CERT_PATH="$CERTS_DIR/nodes/$CERT_NAME.crt"
KEY_PATH="$CERTS_DIR/nodes/$CERT_NAME.key"

[[ -f "$CERT_PATH" ]] && echo_exit "A .crt file named $CERT_NAME already exists in ./certs/nodes/$CERT_NAME.crt"
[[ -f "$KEY_PATH" ]] && echo_exit "A .key file named $CERT_NAME already exists in ./certs/nodes/$CERT_NAME.key"

echo 'Hostname(s) of node:'
read -p "> " NODE_HOSTNAMES

docker run --rm -v "$CERTS_DIR:/certs" cockroachdb/cockroach:beta-20161110 cert create-node $NODE_HOSTNAMES --ca-cert=/certs/ca.crt --ca-key=/certs/ca.key --cert="/certs/nodes/$CERT_NAME.crt" --key="/certs/nodes/$CERT_NAME.key"
