#!/bin/bash

source "${BASH_SOURCE%/*}/common.sh"

docker-compose run cockroachdb sql --certs-dir=/certs
