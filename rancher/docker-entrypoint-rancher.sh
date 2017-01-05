#!/bin/sh
set -e

PREFIX=$(curl -s http://rancher-metadata.rancher.internal/2015-12-19/self/service/stack_name)/$(curl -s http://rancher-metadata.rancher.internal/2015-12-19/self/service/name)

[ "$PREFIX" == '/' ] && (echo "PREFIX must be set to run this container, but can't get its stack and service name from rancher metadata"; exit 1)

export PREFIX

./docker-entrypoint.sh $@
