#!/bin/sh
#
# A helper script for ENTRYPOINT.
set -e

IFS=$'\n'
envsubst '${RSNAPSHOT_HOURLY_RETAIN}${RSNAPSHOT_DAILY_RETAIN}${RSNAPSHOT_WEEKLY_RETAIN}${$RSNAPSHOT_MONTHLY_RETAIN}${RSNAPSHOT_YEARLY_RETAIN}' < /etc/rsnapshot.conf.tpl > /etc/rsnapshot.conf
for backup in `echo -e $BACKUP_DIRECTORIES`; do
  AUX=`echo $backup | sed -r  "s@(^[^ ]+) +@\1\t./${PREFIX}/@g"`
  echo -e "backup\t$AUX" >> /etc/rsnapshot.conf
done

exec rsnapshot "$@"
