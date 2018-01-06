.PHONY : deploy

SHELL := bash -e

CONFIG_DIR := $(HOME)/.config/i3

DIRECTORIES += $(CONFIG_DIR)

include ../common.mk

deploy: | $(CONFIG_DIR)
	$(WITH_DEPLOY_HELPER); \
		deploy_if_diff "$|" config i3*

