.PHONY : deploy


CONFIG_DIR=$(HOME)/.config/zsh
$(CONFIG_DIR) :
	mkdir -p "$@"

$(HOME)/.zshenv : zshenv
	cp $< $@

$(CONFIG_DIR)/.% : %
	cp $< $@

$(CONFIG_DIR)/% : %
	cp -L $< $@


deploy : $(HOME)/.zshenv $(CONFIG_DIR)/.zshrc $(CONFIG_DIR)/alias.zsh | $(CONFIG_DIR)
	# no-op
