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
	run_with_timeout \
	seqdo \
	sshdiff

# for _zsh in $(dirname $0)/functions/*
# do
# 	source $_zsh
# done
# vim: ft=zsh
