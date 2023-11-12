#
# pyenv_activate
# ===
# Activate python virtual environement
#
# pyenv_activate env_name [search_paths ...]
#
pyenv_activate()  {
	local search_paths=(~/.virtualenv{,s} ~/.pyenv{,s} ~/.venv{,s} .)
	[[ -n "${@:2}" ]] && search_paths=("${@:2}")
	for root in $search_paths; do
		[[ -f "$root/$1/bin/activate" ]] && source "$root/$1/bin/activate" && return
	done
	printf "Fail to find activate script for $1 in $search_paths\n" > /dev/stderr
	return 1
}

# vim: ft=zsh
