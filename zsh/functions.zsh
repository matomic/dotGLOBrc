fpath=($(dirname $0)/functions $fpath)
autoload +X \
	find_ssh_auth_sock \
	hgrep \
	seqdo \
	argsep \
	extract \
	pyenv_activate
# for _zsh in $(dirname $0)/functions/*
# do
# 	source $_zsh
# done

# vim: sh=zsh
