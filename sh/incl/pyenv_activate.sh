#
# pyenv_activate
# ===
# Activate python virtual environement
#
# pyenv_activate env_name [search_paths ...]
#
pyenv_activate () {
	local search_paths=( "${@:2}" ./ ~/.virtualenv{,s} ~/.pyenv{,s} ~/.venv{,s} )
	for root in $search_paths
	do
		if [[ -f $root/$1/bin/activate ]];
		then
			source $root/$1/bin/activate
			return
		fi
	done
	printf "Fail to find activate script for $1 in $search_paths\n" > /dev/stderr
	return 1
}
