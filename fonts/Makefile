.PHONY: deploy

SHELL := bash -e

CONFIG_DIR := $(HOME)/.config/fontconfig
DIRECTORIES += $(CONFIG_DIR) $(CONFIG_DIR)/conf.d

include ../common.mk

deploy : | $(DIRECTORIES)
	$(WITH_DEPLOY_HELPER); { \
		deploy_if_diff "$|"/conf.d [0-9]*.conf; \
	}

