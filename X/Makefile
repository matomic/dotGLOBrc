SHELL := bash -e

XRD_DIR := $(HOME)/.Xresources.d
DIRECTORIES += $(XRD_DIR)
include ../common.mk

deploy : | $(XRD_DIR)
	$(WITH_DEPLOY_HELPER); \
		deploy_if_diff ~/.Xresources Xresources; \
		deploy_if_diff "$|" Xresources.d/*
