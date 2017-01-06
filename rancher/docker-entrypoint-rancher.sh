#!/bin/sh
set -e

STACK_NAME=$(curl -s http://rancher-metadata.rancher.internal/2015-12-19/self/service/stack_name)
SERVICE_NAME=$(curl -s http://rancher-metadata.rancher.internal/2015-12-19/self/service/name)

[ -z "$STACK_NAME" ] && (echo "can't get containers stack name from rancher metadata"; exit 1)
[ -z "$SERVICE_NAME" ] && (echo "can't get containers service name from rancher metadata"; exit 1)

# If PREFIX is empty, defaults to SERVICE_NAME
PREFIX=${PREFIX:-${SERVICE_NAME}}

# PREFIX will be STACK_NAME/PREFIX
PREFIX=${PREFIX:+${STACK_NAME}/${PREFIX}}

export PREFIX

./docker-entrypoint.sh $@
