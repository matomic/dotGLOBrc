#!/usr/bin/env zsh
#
# find_ssh_auth_sock
# ====
# Find a valid ssh-agent socket and print the environment variable export
# needed to use it
#
# Default search in /tmp/ssh-* and /tmp/com.apple.launchd.*
# Addition search path can be added as argument
#
# e.g.
# > find_ssh_auth_sock
# SSH_AUTH_SOCK=/tmp/com.apple.launchd.G9r6dLT2nV/Listeners; export SSH_AUTH_SOCK
#
# return 0 if success, 2 otherwise.
find_ssh_auth_sock() {
	autoload -Uz test_ssh_auth_sock
	for sock in $( find  /tmp/ssh-*(N) /tmp/com.apple.launchd.*/Listeners(N) "$@" -type s 2> /dev/null )
	do
		if test_ssh_auth_sock $sock
		then
			printf "SSH_AUTH_SOCK=$sock; export SSH_AUTH_SOCK\n"; return 0;
		fi
	done
	return 2
}

# vim: ft=zsh
