.PHONY: deploy

SHELL := bash -e

XDG_CONFIG_HOME ?= $(HOME)/.config

CONFIG_DIR := $(XDG_CONFIG_HOME)/fontconfig
DIRECTORIES += $(CONFIG_DIR) $(CONFIG_DIR)/conf.d

include ../common.mk

deploy : | $(DIRECTORIES)
	$(WITH_DEPLOY_HELPER); { \
		deploy_if_diff "$|"/conf.d [0-9]*.conf; \
	}
