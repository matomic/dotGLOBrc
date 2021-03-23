.PHONY : deploy

SHELL := bash -e

BASH_DIR := $(HOME)/.bashrc.d
BASHRC := $(HOME)/.bashrc
MODULES_DIR := $(BASH_DIR)/modules
DIRECTORIES += $(BASH_DIR) $(MODULES_DIR)

MODULES := base16-shell

include ../common.mk

deploy : | $(MODULES_DIR)
	$(WITH_DEPLOY_HELPER); \
		rsync -avP --delete modules/ "$|"/; \
		deploy_if_diff "$(BASH_DIR)" incl/*.sh *.sh *.user; \
		if [[ ! -f "$(BASHRC)" ]]; then ln -s .bashrc.d/bashrc.user "$(BASHRC)"; fi
