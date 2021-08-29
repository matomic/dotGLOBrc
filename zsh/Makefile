.PHONY : deploy


ZDOTDIR=$(HOME)/.config/zsh

$(ZDOTDIR) :
	mkdir -p "$@"

$(HOME)/.zshenv : zshenv
	cp -L "$<" "$@"

$(ZDOTDIR)/.% : % | $(ZDOTDIRS)
	cp -L "$<" "$@"

$(ZDOTDIR)/% : % | $(ZDOTDIR)
	cp -L "$<" "$@"

$(ZDOTDIR)/plugins : plugins
	printf "Deploying plugins\n"; rsync -avP plugins/ $(ZDOTDIR)/plugins/

$(ZDOTDIR)/functions :functions
	printf "Deploying functions\n"; rsync -avP functions/ $(ZDOTDIR)/functions/

DEPLOY_TARGETS := $(HOME)/.zshenv \
	$(ZDOTDIR)/.zshrc \
	$(ZDOTDIR)/alias.zsh \
	$(ZDOTDIR)/completion.zsh \
	$(ZDOTDIR)/plugins \
	$(ZDOTDIR)/functions \
	$(ZDOTDIR)/prompt_purification_setup


deploy : $(DEPLOY_TARGETS) | $(ZDOTDIR)
	# deployed $+
