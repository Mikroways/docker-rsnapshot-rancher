# rsnapshot docker container

This container provides rsnapshot binary installed on top of alpine Linux. It
will backup directories specified with `BACKUP_DIRECTORIES` environment variable
and keep `RETAIN` retantions that can be modified by this environment variable

## Usage

```bash
 docker run -e RETAIN=10 \
    -e BACKUP_DIRECTORIES=/dir1\ ./dir1\\n/dir2\ ./dir2 \
    --rm mikroways/rsnapshot:latest
```

## Options

`rsnapshot` is configured with the folowing options:

* **RETAIN:** with a default of 5
* **EXCLUDE:** rsnapshot exclude option. It can be specified using \n to have
  multiple exclude
* **INCLUDE:** rsnapshot include option. It can be specified using \n to have
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
