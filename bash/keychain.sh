
## Enable ssh-agent and gpg-agent {{{
eval_keychain() {
	# eval keychain, if failed, stop existing ssh-agent and try again
	eval `keychain --eval $*` || eval `keychain --stop all --eval $*`
}

init_keychain() {
	keychainbin=$(which keychain 2> /dev/null)
	gpgagentbin=$(which gpg-agent 2> /dev/null)
	if [ "x${keychainbin}" != "x" ]; then
		if [ "x${gpgagentbin}" != "x" ]; then
			eval `keychain --agents gpg --eval`;
		fi
		identities=''
		for id in id_dsa id_rsa id_ecdsa; do
			if [ -f "${HOME}/.ssh/${id}" ]; then
				identities="${identities} ${id}"
			fi
		done
		if [ "x${identities}" != "x" ]; then
			eval_keychain --quiet --agents ssh ${identities} $*
			exportstr=`keychain --eval --agents ssh ${identities} $* --quiet`
			alias ssh="${exportstr} /usr/bin/ssh"
		fi
	fi
}
#GPG_TTY=$(tty)
#export GPG_TTY
init_keychain 2> /dev/null
init_keychain
## }}}

unset keychainbin

## vim: foldmethod=marker ft=sh noet sta ts=2 sw=2
