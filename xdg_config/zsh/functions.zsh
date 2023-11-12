fnsdir=$(dirname $0)/functions
fpath=(${fnsdir} $fpath)
autoload +X \
	argsep \
	eval_ssh_auth_sock \
	extract \
	find_ssh_auth_sock \
	genpasswd \
	genrandomwords \
	hgrep \
	pyenv_activate \
	run_with_timeout \
	seqdo \
	sshdiff

# autoload +X ${fnsdir}/*(N)

# vim: ft=zsh
