#!/bin/sh
#
# A helper script for ENTRYPOINT.
set -e
set -o noglob

[ -z "${PREFIX}" ] || mkdir -p /var/rsnapshot/${PREFIX}

envsubst '${RETAIN_HOURLY}${RETAIN_DAILY}${RETAIN_WEEKLY}${RETAIN_MONTHLY}${RETAIN_YEARLY}${PREFIX}' < /etc/rsnapshot.conf.tpl > /etc/rsnapshot.conf

echo $BACKUP_DIRECTORIES | sed 's/:/\t/g' | tr ';' '\n' | sed 's/^/backup\t/' >> /etc/rsnapshot.conf

if [ ! -z "${INCLUDE}" ]; then
  echo $INCLUDE |  tr ';' '\n' | sed 's/^/include\t/' >> /etc/rsnapshot.conf
fi

if [ ! -z "${EXCLUDE}" ]; then
  echo $EXCLUDE |  tr ';' '\n' | sed 's/^/exclude\t/' >> /etc/rsnapshot.conf
fi

echo Starting rnsapshot with config file:
cat /etc/rsnapshot.conf
echo Starting rnsapshot:
exec rsnapshot "$@"
