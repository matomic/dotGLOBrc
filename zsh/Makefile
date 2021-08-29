.PHONY : deploy


ZDOTDIR=$(HOME)/.config/zsh

$(ZDOTDIR) :
	mkdir -p "$@"

$(HOME)/.zshenv : zshenv
	cp $< $@

$(ZDOTDIR)/.% : %
	cp $< $@

$(ZDOTDIR)/% : %
	cp -L $< $@

$(ZDOTDIR)/plugins : plugins
	printf "Deploying plugins\n"; rsync -avP plugins/ $(ZDOTDIR)/plugins/

DEPLOY_TARGETS := $(HOME)/.zshenv $(ZDOTDIR)/.zshrc $(ZDOTDIR)/alias.zsh $(ZDOTDIR)/plugins


deploy : $(DEPLOY_TARGETS) | $(ZDOTDIR)
	# no-op
