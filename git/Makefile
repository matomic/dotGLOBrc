.PHONY : deploy

SHELL := bash -e

include ../common.mk

$(HOME)/.gitconfig : gitconfig
	$(WITH_DEPLOY_HELPER); { \
		deploy_if_diff "$@" "$<"; \
		}


deploy : $(HOME)/.gitconfig
