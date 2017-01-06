ifeq ($(TAG),)
  $(error TAG is not set)
endif

all: main rancher
push: all
	docker push mikroways/rsnapshot:latest
	docker push mikroways/rsnapshot:$(TAG)
	docker push mikroways/rancher-rsnapshot:latest
	docker push mikroways/rancher-rsnapshot:$(TAG)

.PHONY: main rancher push

main:
	docker build -t mikroways/rsnapshot:latest . && \
		docker build -t mikroways/rsnapshot:$(TAG) .

rancher: main
	cd rancher && \
		docker build -t mikroways/rancher-rsnapshot:latest . && \
		docker build -t mikroways/rancher-rsnapshot:$(TAG) .


