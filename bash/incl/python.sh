# python helper
pyhelp() {
	local pkg=${1//\//.}
	local pkg=${pkg%%.}
	while [ -n "${pkg}" ]; do
		python -c "import ${pkg} as x; help(x)" \
			|| python -c "from ${pkg%.*} import ${pkg##*.} as x; help(x)" \
			&& return
		if [ "x${pkg}" = "x${pkg%.*}" ]; then
			return 1
		else
			pkg="${pkg%.*}";
			printf "Trying pkg ${pkg}\n" > /dev/stderr;
		fi
	done
}

pyenv_activate() {
	local root=
	for root in $1 ~/.virtualenv/$1
	do
		if [[ -f $root/bin/activate ]];
		then
			source $root/bin/activate
			return
		fi
	done
	printf "fail to find activate script for $1\n"
	false
}
