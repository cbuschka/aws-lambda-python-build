#PROJECT_DIR := $(dir $(firstword $(MAKEFILE_LIST)))
PROJECT_DIR := $(shell pwd)

define frobnicate =
	@echo "frobnicating target $@"
	frob-step-1 $< -o $@-step-1
	frob-step-2 $@-step-1 -o $@
endef

build:	__init
	docker build -f ${PROJECT_DIR}/build/Dockerfile -t aws-lambda-python37:latest ${PROJECT_DIR}/build/
	rm -rf ${PROJECT_DIR}/target/example
	mkdir -p ${PROJECT_DIR}/target/example
	docker run -u $(shell id -u):$(shell id -g) --init -ti --rm \
		-v ${HOME}/.cache/pip/:/.cache/pip/:rw \
		-v ${PROJECT_DIR}/lambda/example:/src:ro \
		-v ${PROJECT_DIR}/target/example:/target:rw \
		aws-lambda-python37:latest

__init:
	echo "Init..."
