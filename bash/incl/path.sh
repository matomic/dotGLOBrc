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
