# rsnapshot docker container

This container provides rsnapshot binary installed on top of alpine Linux. It
will backup directories specified with `BACKUP_DIRECTORIES` environment variable
and keep N retantions that can be modified by other environment variables

## Usage

```bash
 docker run -e 'BACKUP_DIRECTORIES=/dir1\ ./dir1\\n/dir2\ ./dir2 \
    --rm mikroways/rsnapshot:2.0.0
```

This line will run an hoirly backup. If you want to make it explicit:

```bash
 docker run -e 'BACKUP_DIRECTORIES=/dir1\ ./dir1\\n/dir2\ ./dir2 \
    --rm mikroways/rsnapshot:2.0.0 hourly
```

## Options

`rsnapshot` is configured with the folowing options:

* **hourly:** with a default retention of 11
* **daily:** with a default retention of 6
* **weekly:** with a default retention of 4
* **monthly:** with a default retention of 11
* **yearly:** with a default retention of 4

So you can change de default command `hourly` with any of the above options. 

`rsnapshot` has been modified to always log to stdout so logs can be obtained
from outside and detect failures

## Building

There is a Makefile that simplifies the iage building. We provide two images,
`rancher-rsnapshot` is a modification that always set PREFIX to service stack
and name of the runing container
