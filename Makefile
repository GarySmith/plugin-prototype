# Copyright (c) 2019 VMware, Inc. All Rights Reserved.
# SPDX-License-Identifier: Apache-2.0

SHELL:=/bin/bash
BUILD_TIME=$(shell date -u +%Y-%m-%dT%T%z)
GIT_COMMIT=$(shell git rev-parse --short HEAD)

LD_FLAGS= '-X "main.buildTime=$(BUILD_TIME)" -X main.gitCommit=$(GIT_COMMIT)'
GO_FLAGS= -ldflags=$(LD_FLAGS)

ifdef XDG_CONFIG_HOME
	OCTANT_PLUGINSTUB_DIR ?= ${XDG_CONFIG_HOME}/octant/plugins
# Determine in on windows
else ifeq ($(OS),Windows_NT)
	OCTANT_PLUGINSTUB_DIR ?= ${LOCALAPPDATA}/octant/plugins
else
	OCTANT_PLUGINSTUB_DIR ?= ${HOME}/.config/octant/plugins
endif

DIRS = internal pkg
RECURSIVE_DIRS = $(addsuffix /...,$(DIRS))

.PHONY: plugin
plugin:
	mkdir -p $(OCTANT_PLUGINSTUB_DIR)
	go build -o $(OCTANT_PLUGINSTUB_DIR)/octant-sample-plugin github.com/vmware/octant/cmd/octant-sample-plugin

.PHONY: test
test: generate
	go test -v $(RECURSIVE_DIRS)

.PHONY: vet
vet:
	go vet $(RECURSIVE_DIRS)

.PHONY: generate
generate:
	go generate -v $(RECURSIVE_DIRS)

# Remove all generated go files
.PHONY: clean
clean:
	git clean -dx $(DIRS)

.PHONY: changelogs
changelogs:
	hacks/changelogs.sh

.PHONY: ci
ci: test vet
