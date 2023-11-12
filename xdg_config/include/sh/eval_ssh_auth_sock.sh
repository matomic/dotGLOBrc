eval_ssh_auth_sock() {
	[ -n "$($SHELL -c 'echo $ZSH_VERSION')" ] && autoload -Uz find_ssh_auth_sock
	eval $(find_ssh_auth_sock)
}

# vim: ft=zsh
