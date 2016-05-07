
## Helper functions
# source additional files with extension $2 in $1
sourceFilesInDir () {
	[ -d "$1" ] && \
		for f in "${1}"/*; do
			[ -f ${f} -a "x${f%$2}" != "x${f}" ] && . "${f}" # only source those with certain extension
		done
}
# }}}

# Path helper functions
pathremove () {
	local IFS=':'
	local NEWPATH
	local DIR
	local PATHVARIABLE=${2:-PATH}
	for DIR in ${!PATHVARIABLE} ; do
		if [ "$DIR" != "$1" ] ; then
			NEWPATH=${NEWPATH:+$NEWPATH:}$DIR
		fi
	done
	export $PATHVARIABLE="$NEWPATH"
}

pathprepend () {
	pathremove $1 $2
	local PATHVARIABLE=${2:-PATH}
	export $PATHVARIABLE="$1${!PATHVARIABLE:+:${!PATHVARIABLE}}"
}

pathappend () {
	pathremove $1 $2
	local PATHVARIABLE=${2:-PATH}
	export $PATHVARIABLE="${!PATHVARIABLE:+${!PATHVARIABLE}:}$1"
}

uniq_path () {
	echo $1 | tr ':' '\n' | cat -n | sort -uk2 | sort -nk1 | cut -f2- | \
		while read x
		do
			[[ -n "$x" ]] && printf "$x:"
		done
}

## useful functions
# grep history
hgrep() {
	history | grep $*
}

# use server/client mode for gvim
g() {
	if [ "x$1" = "x" ]
	then
		gvim > /dev/null 2>&1 &
	else
		if [ -z "`gvim --serverlist`" ]
		then
			printf "gvim $*\n"
			gvim $* > /dev/null 2>&1 &
		else
			printf "gvim --remote-silent $*\n"
			gvim --remote-silent $* 21> /dev/null
		fi
	fi 
}

# generates a random integer
random() {
	dd if=/dev/urandom count=1 2> /dev/null | cksum | cut -f1 -d" "
}

# generates random password
genpasswd() {
	local l=$1
	[ -z "$l" ] && l=20
	tr -dc A-Za-z0-9_ < /dev/urandom | head -c ${l} | xargs
}

genrandomwords() {
	local w=`egrep "^[a-z]{4,7}$" /usr/share/dict/words | wc -l`
	local c=5
	if [ ! "x$1" = "x" ]; then c="$1"; fi
	for i in `seq $c`; do
		egrep "^[a-z]{4,7}$" /usr/share/dict/words | sed -n "$((RANDOM % w + 1)) p"
	done
}

# update these to your favoite apps:
viewpdf() {
	epdfview "$1" >& /dev/null
}
#

# version string compare
# return 1 if $1 > $2
# return -1 if $2 > $1
# return 0 if equal
vercomp () {
	if [ x"$1" = x"$2" ]; then
		printf "0"; return
	fi

	local pre1=${1%%.*} pre2=${2%%.*}
	if [ "${pre1}" -gt "${pre2}" ]; then
		printf "1"; return 0;
	fi
	if [ "${pre1}" -lt "${pre2}" ]; then
		printf "2"; return 0;
	fi
	if [ "${pre1}" -eq "${pre2}" ]; then
		local post1=${1#${pre1}.} post2=${2#${pre2}.}
		b=`vercomp "${post1}" "${post2}"`
		printf "${b}"; return 0;
	fi
	return 1; # exit with error, usually due to non-numeric $1 or $2
}

# colorful man pages
man() {
	#export LESS_TERMCAP_mb=$'\E[01;31m'       # begin blinking
	#export LESS_TERMCAP_md=$'\E[01;38;5;74m'  # begin bold
	#export LESS_TERMCAP_me=$'\E[0m'           # end mode
	#export LESS_TERMCAP_se=$'\E[0m'           # end standout-mode
	#export LESS_TERMCAP_so=$'\E[38;5;246m'    # begin standout-mode - info box
	#export LESS_TERMCAP_ue=$'\E[0m'           # end underline
	#export LESS_TERMCAP_us=$'\E[04;38;5;146m' # begin underline
	env GROFF_NO_SGR=1 \
		LESS_TERMCAP_mb=$'\E[1;31;2m' \
		LESS_TERMCAP_md=$'\E[1;32m' \
		LESS_TERMCAP_me=$'\E[0m' \
		LESS_TERMCAP_us=$'\E[1;33m' \
		LESS_TERMCAP_ue=$'\E[0m' \
		LESS_TERMCAP_so=$'\E[1;34;7m' \
		LESS_TERMCAP_se=$'\E[0m' \
		man "$@"
}

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
	if [ ! -d "$1" ]; then
		VEPATH="${HOME}/.virtualenv/$1"
	else
		VEPATH="$1"
	fi
	if [ -d "$VEPATH" ]; then
		[ -f "${VEPATH}/bin/activate" ] && . ${VEPATH}/bin/activate
	else
		printf "$VEPATH is not a valid path.\n" && return 1
	fi
}

run_n_times() {
	local n=1;
	if [ "x$1" == "x-n" ]
	then
		n=$2;
		shift 2
	fi

	for x in `seq 1 $n`;
	do
		$*
	done
}

## eof vim: noet sta ts=4 sw=4
