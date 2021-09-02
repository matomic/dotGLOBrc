fpath=($(dirname $0)/functions $fpath)
autoload +X \
	argsep \
	extract \
	find_ssh_auth_sock \
	genpasswd \
	hgrep \
	pyenv_activate\
	seqdo \
	sshdiff \

# vim: ft=zsh
