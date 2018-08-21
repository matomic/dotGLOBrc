.PHONY: deploy

SHELL := bash -e

CONFIG_DIR := $(HOME)/.config/fontconfig
DIRECTORIES += $(CONFIG_DIR)

include ../common.mk

deploy : | $(CONFIG_DIR)
	$(WITH_DEPLOY_HELPER); { \
		deploy_if_diff "$|"/conf.d [0-9]*.conf; \
	}

