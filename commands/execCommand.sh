#!/bin/bash

source "${BASH_SOURCE%/*}/common.sh"

COMMAND=$@

docker-compose run cockroachdb $COMMAND --certs-dir=/certs --ca-key=/certs/ca.key
