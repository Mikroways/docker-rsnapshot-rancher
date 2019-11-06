#################################################
# rsnapshot.conf - rsnapshot configuration file #
#################################################
#                                               #
# PLEASE BE AWARE OF THE FOLLOWING RULES:       #
#                                               #
# This file requires tabs between elements      #
#                                               #
# Directories require a trailing slash:         #
#   right: /home/                               #
#   wrong: /home                                #
#                                               #
#################################################

#######################
# CONFIG FILE VERSION #
#######################
config_version	1.2
snapshot_root	/var/rsnapshot/${PREFIX}

cmd_ssh	/usr/bin/ssh
cmd_cp	/bin/cp
cmd_rm	/bin/rm
cmd_rsync	/usr/bin/rsync
cmd_logger	/usr/bin/logger
verbose	2
loglevel	3
logfile	/var/log/rsnapshot.log
lockfile	/var/run/rsnapshot.pid
retain	hourly	${RETAIN_HOURLY}
retain	daily	${RETAIN_DAILY}
retain	weekly	${RETAIN_WEEKLY}
retain	monthly	${RETAIN_MONTHLY}
retain	yearly	${RETAIN_YEARLY}
rsync_short_args	-aL
rsync_long_args	--delete --numeric-ids --relative --delete-excluded
