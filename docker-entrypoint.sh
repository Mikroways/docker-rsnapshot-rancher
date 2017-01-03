#!/bin/sh
#
# A helper script for ENTRYPOINT.
set -e

IFS=$'\n'

[ -z "${PREFIX}" ] || mkdir -p /var/rsnapshot/${PREFIX}

envsubst '${RETAIN}${PREFIX}' < /etc/rsnapshot.conf.tpl > /etc/rsnapshot.conf
for backup in `echo -e $BACKUP_DIRECTORIES`; do
  AUX=`echo $backup | sed -r  "s@(^[^ ]+) +@\1\t@g"`
  echo -e "backup\t$AUX" >> /etc/rsnapshot.conf
done

exec rsnapshot "$@"
