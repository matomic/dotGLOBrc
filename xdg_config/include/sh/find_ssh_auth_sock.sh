#!/usr/bin/env sh
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
	# If existing SSH_AUTH_SOCK works, we will use that
	if test_ssh_auth_sock ${SSH_AUTH_SOCK}
	then
		printf "SSH_AUTH_SOCK=${SSH_AUTH_SOCK}; export SSH_AUTH_SOCK\n"
		return 0
	else
		unset SSH_AUTH_SOCK
	fi
	find_ssh_auth_sock_ 2> /dev/null | while read sock
	do
		if test_ssh_auth_sock $sock
		then
			printf "SSH_AUTH_SOCK=$sock; export SSH_AUTH_SOCK\n"; return 0;
		fi
	done
	return 2
}

find_ssh_auth_sock_() {
	find /private/tmp/com.apple.launchd.* -type s -name Listeners
	find /tmp/ssh-* /tmp/com.apple.launchd.* /var/folders "$@" -type s -path '*/ssh-*/agent.*'
}
# vim: ft=zsh
