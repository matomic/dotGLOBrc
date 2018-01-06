.PHONY : print-%

COMMON_DIR := $(shell dirname $(lastword $(MAKEFILE_LIST)))
WITH_DEPLOY_HELPER := source $(COMMON_DIR)/deploy_helper.sh

print-% :
	@echo $*=$($*) # print variable $* for debugging

ifdef DIRECTORIES
$(DIRECTORIES) :
	mkdir -p $@
endif
