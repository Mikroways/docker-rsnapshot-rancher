ifeq ($(TAG),)
  $(error TAG is not set)
endif

all: main rancher

.PHONY: main rancher

main:
	docker build -t mikroways/rsnapshot:latest . && \
		docker build -t mikroways/rsnapshot:$(TAG) .

rancher: main
	cd rancher && \
		docker build -t mikrowats/rancher-rsnapshot:latest . && \
		docker build -t mikrowats/rancher-rsnapshot:$(TAG) .

