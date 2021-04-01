.PHONY : deploy

SHELL := bash -e

CONFIG_DIR := $(HOME)/.vim
VIM_RC := $(HOME)/.vimrc
DIRECTORIES += $(CONFIG_DIR)

include ../common.mk

deploy : | $(CONFIG_DIR)
	$(WITH_DEPLOY_HELPER); { \
		deploy_if_diff "$|"        *.vim vimrc.local; \
		deploy_if_diff "$|"/vimrc  vimrc.user;        \
		deploy_if_diff "$|"/gvimrc gvimrc.user;       \
		}
	if [[ ! -f "$(VIM_RC)" ]]; then ln -s .vim/vimrc "$(VIM_RC)"; fi
	# rsync -avP --delete {,"$|"/}bundle/
