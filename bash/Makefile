.PHONY : deploy

SHELL := bash -e

BASH_DIR := $(HOME)/.bashrc.d
BASHRC := $(HOME)/.bashrc
DIRECTORIES += $(BASH_DIR) $(BASH_DIR)/modules

include ../common.mk

deploy : | $(BASH_DIR)/modules
	$(WITH_DEPLOY_HELPER); \
		rsync -avP --delete modules/ "$|"/; \
		deploy_if_diff "$(BASH_DIR)" *.sh *.user; \
		if [[ ! -f "$(BASHRC)" ]]; then ln -s .bashrc.d/bashrc.user "$(BASHRC)"; fi
