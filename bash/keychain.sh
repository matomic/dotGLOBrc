
## Enable ssh-agent and gpg-agent {{{
eval_keychain() {
	# eval keychain, if failed, stop existing ssh-agent and try again
	eval `keychain --eval $*` || (keychain --stop all --quiet; eval $(keychain --stop all --eval $*))
}

init_keychain() {
	local keychainbin=$(which keychain 2> /dev/null)
	local gpgagentbin=$(which gpg-agent 2> /dev/null)
	if [ "x${keychainbin}" != "x" ]
	then
		if [ "x${gpgagentbin}" != "x" ]
		then
			eval `keychain --quiet --agents gpg --eval`;
		fi
		local identities=''
		for id in id_dsa id_rsa id_ecdsa id_ed25519; do
			if [ -f "${HOME}/.ssh/${id}" ]; then
				identities+="${identities} ${id}"
			fi
		done
		if [ "x${identities}" != "x" ]
		then
			eval_keychain --quiet --agents ssh ${identities} $*
			local exportstr=`keychain --eval --agents ssh ${identities} $* --quiet`
			#alias ssh="${exportstr} /usr/bin/ssh"
		fi
	fi
}
## }}}

## vim: foldmethod=marker ft=sh noet sta ts=2 sw=2
