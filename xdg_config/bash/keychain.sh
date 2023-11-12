## Enable ssh-agent and gpg-agent {{{
eval_keychain() {
	# eval keychain, if failed, stop existing ssh-agent and try again
	if ! eval $(keychain --eval $*); then
		keychain --stop all --quiet
		eval $(keychain --eval $*)
	fi
}

init_keychain() {
	local gpgagentbin=$(which gpg-agent 2> /dev/null)
	local keychainopts=
	if which keychain > /dev/null; then
		if [ -n "${gpgagentbin}" ]; then
			eval $(keychain $keychainopts --agents gpg --eval)
		fi
		local identities=$(ls ${HOME}/.ssh/{id_dsa,id_rsa,id_ecdsa,id_ed25519} 2> /dev/null)
		if [ -n "${identities+1}" ]; then
			eval_keychain $keychainopts --agents ssh ${identities} $*
			# local exportstr=`keychain --eval --agents ssh ${identities} $* --quiet`
			# alias ssh="${exportstr} /usr/bin/ssh"
		fi
	fi
}
## }}}

## vim: foldmethod=marker ft=sh noet sta ts=2 sw=2
