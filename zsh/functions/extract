# extract
# ====
# Extract archive by filename pattern matching
#
# extract archive [extractor_args...]
#
# e.g.
#
# extract test.tbz2 -C dest/
extract() {    # Handy Extract Program
	local archive=$1
	if [ -f "$archive" ]
	then
		case "$archive" in
			*.tar.bz2|*.tbz2)
				tar -xvjf  "$@" ;;
			*.tar.gz|*.tgz)
				tar -xvzf  "$@" ;;
			*.bz2)
				bunzip2    "$@" ;;
			*.rar)
				unrar x    "$@" ;;
			*.gz)
				gunzip     "$@" ;;
			*.tar)
				tar -xvf   "$@" ;;
			*.7z)
				7z x       "$@" ;;
			*.zip)
				unzip      "$@" ;;
			*.Z)
				uncompress "$@" ;;
			*)
				echo "'$archive': cannot be extracted via >extract<"
				return 2
				;;
		esac
	else
		echo "$archive: No such file or directory"
		return 1
	fi
}
## vim: ft=zsh
