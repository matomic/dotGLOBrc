.PHONY : deploy bundle/Vundle.vim.git

SHELL := bash -e

CONFIG_DIR := $(HOME)/.vim
VIM_RC := $(HOME)/.vimrc
DIRECTORIES += $(CONFIG_DIR)

include ../common.mk

define GIT_TEMPLATE
$$(CONFIG_DIR)/$(strip $1)/.git :
	[ -x "$$@" ] ||  git clone "$(strip $2)" "$$(dir $$@)"
$(strip $1).git : $$(CONFIG_DIR)/$(strip $1)/.git
	(cd $$(dir $$<); git fetch origin; git merge origin/master)
endef

$(eval $(call GIT_TEMPLATE, bundle/Vundle.vim, https://github.com/VundleVim/Vundle.vim.git))

deploy : bundle/Vundle.vim.git | $(CONFIG_DIR)
	$(WITH_DEPLOY_HELPER); { \
		deploy_if_diff "$|"        *.vim vimrc.local; \
		deploy_if_diff "$|"/vimrc  vimrc.user;        \
		deploy_if_diff "$|"/gvimrc gvimrc.user;       \
		}
	if [[ ! -f "$(VIM_RC)" ]]; then ln -s .vim/vimrc "$(VIM_RC)"; fi
