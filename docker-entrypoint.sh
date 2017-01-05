#!/bin/sh
#
# A helper script for ENTRYPOINT.
set -e
set -o noglob

IFS=$'\n'

[ -z "${PREFIX}" ] || mkdir -p /var/rsnapshot/${PREFIX}

envsubst '${RETAIN}${PREFIX}' < /etc/rsnapshot.conf.tpl > /etc/rsnapshot.conf
for backup in `echo -e $BACKUP_DIRECTORIES`; do
  AUX=`echo $backup | sed -r  "s@(^[^ ]+) +@\1\t@g"`
  echo -e "backup\t$AUX" >> /etc/rsnapshot.conf
done

if [ ! -z "${INCLUDE}" ]; then
  for include in `echo -e $INCLUDE`; do
    echo -e "include\t$include" >> /etc/rsnapshot.conf
  done
fi

if [ ! -z "${EXCLUDE}" ]; then
  for exclude in `echo -e $EXCLUDE`; do
    echo -e "exclude\t$exclude" >> /etc/rsnapshot.conf
  done
fi


exec rsnapshot "$@"
