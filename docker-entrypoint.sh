#!/bin/sh
#
# A helper script for ENTRYPOINT.
set -e

IFS=$'\n'

[ -z "${PREFIX}" ] || PREFIX="${PREFIX}_"

envsubst '${RSNAPSHOT_HOURLY_RETAIN}${RSNAPSHOT_DAILY_RETAIN}${RSNAPSHOT_WEEKLY_RETAIN}${$RSNAPSHOT_MONTHLY_RETAIN}${RSNAPSHOT_YEARLY_RETAIN}${PREFIX}' < /etc/rsnapshot.conf.tpl > /etc/rsnapshot.conf
for backup in `echo -e $BACKUP_DIRECTORIES`; do
  AUX=`echo $backup | sed -r  "s@(^[^ ]+) +@\1\t@g"`
  echo -e "backup\t$AUX" >> /etc/rsnapshot.conf
done

if [ $# -le 1 ]; then
  if [ -z "$1" -o $1 = "configtest" ]; then
    exec rsnapshot "$@"
  else
    exec rsnapshot $PREFIX$1
  fi
else
  exec "$@"
fi
