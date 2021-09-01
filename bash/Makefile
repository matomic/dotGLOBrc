.PHONY : deploy clean base16-shell.git

SHELL := bash -e

BASH_DIR := $(HOME)/.config/bash
BASHRC := $(HOME)/.bashrc
MODULES_DIR := $(BASH_DIR)/modules
DIRECTORIES += $(BASH_DIR) $(MODULES_DIR) $(BASH_DIR)/incl

define GIT_TEMPLATE
$(strip $1)/$(strip $2) : | $(strip $1)
	git clone "$(strip $3)" "$$@"

$(strip $2).git : $(strip $1)/$(strip $2)
	(cd $$<; git fetch origin; git merge origin/master)
endef

$(eval $(call GIT_TEMPLATE, $(BASH_DIR)/modules, base16-shell, https://github.com/chriskempson/base16-shell.git))

include ../common.mk

deploy : base16-shell.git | $(DIRECTORIES)
	$(WITH_DEPLOY_HELPER); \
		deploy_if_diff $(BASH_DIR) $(wildcard bash*) $(wildcard *.sh); \
		deploy_if_diff $(BASH_DIR)/incl $(wildcard incl/*.sh); \
		if [[ ! -f "$(BASHRC)" ]]; then ln -s $(BASH_DIR)/bashrc.user "$(BASHRC)"; fi

clean :
	rm -rf $(BASH_DIR)
	rm -rf $(BASHRC)

# vim: iskeyword+=-
