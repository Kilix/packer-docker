# set default shell
SHELL := $(shell which bash)
ENV = /usr/bin/env

# default shell options
.SHELLFLAGS = -c

.SILENT: ;               # no need for @
.ONESHELL: ;             # recipes execute in same shell
.NOTPARALLEL: ;          # wait for this target to finish
.EXPORT_ALL_VARIABLES: ; # send all vars to shell
default: all;   # default target

.PHONY: all config build

all: build

config:
	cp -n -v config.json.dist config.json

build: config
	ATLAS_TOKEN=$(ATLAS_TOKEN:='') $(ENV) packer build -only=virtualbox-iso -var-file=config.json -force packer.json
