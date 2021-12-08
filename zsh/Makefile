.PHONY : deploy gitrepos clean \
	plugins/zsh-completions.git,         \
	plugins/zsh-syntax-highlighting.git, \
	plugins/purification.git,            \
	themes/powerlevel9k.git,             \
	themes/powerlevel10k.git


ZDOTDIR=$(HOME)/.config/zsh

define GIT_TEMPLATE
$$(ZDOTDIR)/$(strip $1) :
	git clone "$(strip $2)" "$$@"

$(strip $1).git : $$(ZDOTDIR)/$(strip $1)
	(cd $$<; git fetch origin; git merge origin/master)
endef

$(eval $(call GIT_TEMPLATE, plugins/zsh-completions, https://github.com/zsh-users/zsh-completions.git))
$(eval $(call GIT_TEMPLATE, plugins/zsh-syntax-highlighting, https://github.com/zsh-users/zsh-syntax-highlighting.git))
$(eval $(call GIT_TEMPLATE, plugins/purification, https://github.com/Phantas0s/purification.git))
$(eval $(call GIT_TEMPLATE, themes/powerlevel10k, https://github.com/romkatv/powerlevel10k.git))
$(eval $(call GIT_TEMPLATE, themes/powerlevel9k, https://github.com/bhilburn/powerlevel9k.git))

$(ZDOTDIR) :
	mkdir -p "$@"

include ../common.mk

DEPLOY_TARGETS := $(HOME)/.zshenv       \
	$(ZDOTDIR)/.zshrc                   \
	$(ZDOTDIR)/alias.zsh                \
	$(ZDOTDIR)/completion.zsh           \
	$(ZDOTDIR)/functions.zsh            \
	$(ZDOTDIR)/functions                \
	gitrepos

gitrepos : \
	plugins/zsh-completions.git         \
	plugins/zsh-syntax-highlighting.git \
	plugins/purification.git            \
	themes/powerlevel9k.git             \
	themes/powerlevel10k.git            \

deploy : $(DEPLOY_TARGETS) | $(ZDOTDIR)
	# deployed $+

clean :
	rm -rf $(ZDOTDIR)/*
	rm -rf $(ZDOTDIR)/.zshrc

$(HOME)/.zshenv : zshenv
	$(WITH_DEPLOY_HELPER); deploy_if_diff $@ $<

$(ZDOTDIR)/.% : % | $(ZDOTDIR)
	$(WITH_DEPLOY_HELPER); deploy_if_diff $@ $<

$(ZDOTDIR)/% : % | $(ZDOTDIR)
	$(WITH_DEPLOY_HELPER); deploy_if_diff $@ $<

RSYNC = rsync
RSYNC_OPTS = -avP --delete --copy-unsafe-links

$(ZDOTDIR)/functions : functions
	printf "Deploying functions\n"; $(RSYNC) $(RSYNC_OPTS) functions/ $(ZDOTDIR)/functions/

# vim: iskeyword+=-
