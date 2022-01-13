fpath=($(dirname $0)/functions $fpath)
autoload +X \
	argsep \
	eval_ssh_auth_sock \
	extract \
	find_ssh_auth_sock \
	genpasswd \
	genrandomwords \
	hgrep \
	pyenv_activate \
	seqdo \
	sshdiff

# vim: ft=zsh
