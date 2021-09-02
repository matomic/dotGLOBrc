.PHONY : print-%

COMMON_DIR := $(dir $(lastword $(MAKEFILE_LIST)))
WITH_DEPLOY_HELPER := . $(COMMON_DIR)/deploy_helper.sh

print-% :
	@echo $*=$($*) # print variable $* for debugging

ifdef DIRECTORIES
$(DIRECTORIES) :
	mkdir -p $@
endif
