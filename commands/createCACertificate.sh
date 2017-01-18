#!/bin/bash

source "${BASH_SOURCE%/*}/common.sh"

mkdir -p "$CERTS_DIR"

CA_CERT="$CERTS_DIR/ca.crt"
CA_KEY="$CERTS_DIR/ca.key"
[[ -f "$CA_CERT" ]] && echo_exit "A ca.crt file already exists in ./certs/ca.crt"
[[ -f "$CA_KEY" ]] && echo_exit "A ca.key file already exists in ./certs/ca.key"

docker run --rm -v "$CERTS_DIR:/certs" cockroachdb/cockroach:beta-20161110 cert create-ca --ca-cert=/certs/ca.crt --ca-key=/certs/ca.key
