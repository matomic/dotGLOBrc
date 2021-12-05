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
