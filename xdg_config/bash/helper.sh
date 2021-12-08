_THISDIR=`dirname ${BASH_SOURCE[0]}`
for _sh in $_THISDIR/incl/*.sh
do
	source $_sh
done
unset _THISDIR _sh

## Helper functions
# source additional files with extension $2 in $1
sourceFilesInDir () {
	[ -d "$1" ] && \
		for f in "${1}"/*; do
			[ -f ${f} -a "x${f%$2}" != "x${f}" ] && . "${f}" # only source those with certain extension
		done
}

## useful functions

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

extract() {    # Handy Extract Program
	if [ -f $1 ] ; then
		case $1 in
			*.tar.bz2)
				tar xvjf "$l" ;;
			*.tar.gz)
				tar xvzf "$1" ;;
			*.bz2)
				bunzip2 "$l"  ;;
			*.rar)
				unrar x "$1"  ;;
			*.gz)
				gunzip "$1"   ;;
			*.tar)
				tar xvf "$1"  ;;
			*.tbz2)
				tar xvjf "$1" ;;
			*.tgz)
				tar xvzf "$1" ;;
			*.zip)
				unzip "$1"    ;;
			*.Z)
				uncompress $1 ;;
			*.7z)
				7z x $1       ;;
			*)
				echo "'$1' cannot be extracted via >extract<"
				return 1
				;;
		esac
	else
		echo "'$1' is not a valid file!"
		return 1
	fi
}

## eof vim: noet sta ts=4 sw=4
