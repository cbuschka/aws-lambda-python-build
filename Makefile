#PROJECT_DIR := $(dir $(firstword $(MAKEFILE_LIST)))
PROJECT_DIR := $(shell pwd)
BUILD_NO := $(shell date +'%Y%m%d%H%M%S')

define build_lambda =
	echo "Building lambda ${1}..."
	docker build -f ${PROJECT_DIR}/build/Dockerfile -t pybuild-build-${1}:latest ${PROJECT_DIR}/lambda/${1}/
	rm -rf ${PROJECT_DIR}/target/${1} && mkdir -p ${PROJECT_DIR}/target/${1}
	docker run -u $(shell id -u):$(shell id -g) -ti --rm \
		-v ${PROJECT_DIR}/target/${1}:/target:rw \
		pybuild-build-${1}:latest
endef

build:	example example2

example:	__init
	$(call build_lambda,example)

example2:	__init
	$(call build_lambda,example2)

__init:
	echo "Init..."
