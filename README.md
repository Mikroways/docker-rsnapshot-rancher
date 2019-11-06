# rsnapshot docker container

This container provides rsnapshot binary installed on top of alpine Linux. It
will backup directories specified with `BACKUP_DIRECTORIES` environment variable
and keep retantions that can be modified by  environment variables

## Usage

```bash
 docker run -e RETAIN=10 \
    -e BACKUP_DIRECTORIES=/dir1:./dir1;/dir2:./dir2 \
    --rm mikroways/rsnapshot:latest
```

## Options

`rsnapshot` is configured with the folowing options:

* **BACKUP_DIRECTORIES:** list of directories to backup. It is a list of source
  directories and destination directories specified in the following format:
`source_dir1:destination_dir1;source_dir2:destination_dir2`
* **BACKUP_REMOTE_DIRECTORIES:** list of remote directories to backup. It is a list of remote source
  directories and destination directories specified in the following format:
`user@ip_soruce:source_dir1:destination_dir1;user2@ip_soruce2:source_dir2:destination_dir2`
* **RETAIN_HOURLY:** hourly retention. Defaults to 23
* **RETAIN_DAILY:** Daily retention. Defaults to 6
* **RETAIN_WEEKLY:** Weekly retention. Defaults to 3
* **RETAIN_MONTHLY:**  Monthly retention. Defaults to 11
* **RETAIN_YEARLY:**  Yearly retention. Defaults to 2
* **EXCLUDE:** rsnapshot exclude option. It can be specified using ; to have
  multiple exclude
* **INCLUDE:** rsnapshot include option. It can be specified using ; to have
  multiple include

`rsnapshot` has been modified to always log to stdout so logs can be obtained
from outside and detect failures

**This image always will declare include patterns before exclude patterns**

## Building

There is a Makefile that simplifies the image building. We provide two images,
`rancher-rsnapshot` is a modification that always set PREFIX to service stack
and name of the runing container
You always need to set TAG environment variable so image is tagged. This is only
for testing, because we are using docker hub automated builds

```bash
TAG=1.0.1-test make
```

## Important

When running on rancher, consider using a scheduler to keep all backup
containers on same host to allow rsnapshot to use its own check of consistency
by lock files. To do this all containers must share `/var/run/` volume.

To run rsnapshot periodically, it is advised to combine run once containers
with [rancher-chron](https://github.com/SocialEngine/rancher-cron)

A sample docker-compose.yml file should look like:

```yml

```
