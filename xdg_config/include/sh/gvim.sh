#!/usr/bin/env sh

# use server/client mode for gvim
g() {
	if [ "x$1" = "x" ]; then
		gvim > /dev/null 2>&1 &
	else
		if [ -z "$(gvim --serverlist)" ]; then
			printf "gvim $*\n"
			gvim $* > /dev/null 2>&1 &
		else
			printf "gvim --remote-silent $*\n"
			gvim --remote-silent $* 21> /dev/null
		fi
	fi
}
