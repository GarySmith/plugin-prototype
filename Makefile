# Copyright (c) 2019 VMware, Inc. All Rights Reserved.
# SPDX-License-Identifier: Apache-2.0

SHELL=/bin/bash
BUILD_TIME=$(shell date -u +%Y-%m-%dT%T%z)
GIT_COMMIT=$(shell git rev-parse --short HEAD)

LD_FLAGS= '-X "main.buildTime=$(BUILD_TIME)" -X main.gitCommit=$(GIT_COMMIT)'
GO_FLAGS= -ldflags=$(LD_FLAGS)
GOCMD=go
GOBUILD=$(GOCMD) build
GOINSTALL=$(GOCMD) install

VERSION ?= v0.6.0

ifdef XDG_CONFIG_HOME
	OCTANT_PLUGINSTUB_DIR ?= ${XDG_CONFIG_HOME}/octant/plugins
# Determine in on windows
else ifeq ($(OS),Windows_NT)
	OCTANT_PLUGINSTUB_DIR ?= ${LOCALAPPDATA}/octant/plugins
else
	OCTANT_PLUGINSTUB_DIR ?= ${HOME}/.config/octant/plugins
endif

.PHONY: version
version:
	@echo $(VERSION)

# Run all tests
.PHONY: test
test: generate
	@echo "-> $@"
	@env go test -v ./internal/... ./pkg/...

# Run govet
.PHONY: vet
vet:
	@echo "-> $@"
	@env go vet ./internal/... ./pkg/...

generate:
	@echo "-> $@"
	@go generate -v ./pkg/... ./internal/...

# Remove all generated go files
.PHONY: clean
clean:
	@rm -rf ./internal/octant/fake
	@rm -rf ./internal/kubeconfig/fake
	@rm -rf ./internal/link/fake
	@rm -rf ./internal/event/fake
	@rm -rf ./internal/config/fake
	@rm -rf ./internal/api/fake
	@rm -rf ./internal/portforward/fake
	@rm -rf ./internal/objectstore/fake
	@rm -rf ./internal/queryer/fake
	@rm -rf ./internal/cluster/fake
	@rm -rf ./internal/module/fake
	@rm -rf ./internal/modules/overview/printer/fake
	@rm -rf ./pkg/store/fake
	@rm -rf ./pkg/plugin/fake
	@rm -rf ./pkg/plugin/api/fake
	@rm -rf ./pkg/plugin/service/fake
	@rm ./pkg/icon/rice-box.go

.PHONY: changelogs
changelogs:
	hacks/changelogs.sh

.PHONY: release
release:
	git tag -a $(VERSION) -m "Release $(VERSION)"
	git push --follow-tags

.PHONY: ci
ci: test vet

install-test-plugin:
	@echo $(OCTANT_PLUGINSTUB_DIR)
	mkdir -p $(OCTANT_PLUGINSTUB_DIR)
	go build -o $(OCTANT_PLUGINSTUB_DIR)/octant-sample-plugin github.com/airship-ui/cmd/octant-sample-plugin

.PHONY:
build-deps:
