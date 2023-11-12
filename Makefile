.PHONY: deploy stow

STOW := /usr/bin/stow
XDG_CONFIG_HOME ?= $(HOME)/.config

deploy :
	make -C bash deploy
	make -C vim deploy
	make -C X deploy
	make -C fonts deploy

stow :
	$(STOW) -t $(XDG_CONFIG_HOME) --dotfiles xdg_config
	$(STOW) -t $(HOME) --dotfiles home_config
