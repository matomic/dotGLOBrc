#!/usr/bin/env sh

# colorful man pages
man() {
	#export LESS_TERMCAP_mb=$'\E[01;31m'       # begin blinking
	#export LESS_TERMCAP_md=$'\E[01;38;5;74m'  # begin bold
	#export LESS_TERMCAP_me=$'\E[0m'           # end mode
	#export LESS_TERMCAP_se=$'\E[0m'           # end standout-mode
	#export LESS_TERMCAP_so=$'\E[38;5;246m'    # begin standout-mode - info box
	#export LESS_TERMCAP_ue=$'\E[0m'           # end underline
	#export LESS_TERMCAP_us=$'\E[04;38;5;146m' # begin underline
	env GROFF_NO_SGR=1 \
		LESS_TERMCAP_mb=$'\E[1;31;2m' \
		LESS_TERMCAP_md=$'\E[1;32m' \
		LESS_TERMCAP_me=$'\E[0m' \
		LESS_TERMCAP_us=$'\E[1;33m' \
		LESS_TERMCAP_ue=$'\E[0m' \
		LESS_TERMCAP_so=$'\E[1;34;7m' \
		LESS_TERMCAP_se=$'\E[0m' \
		man "$@"
}
