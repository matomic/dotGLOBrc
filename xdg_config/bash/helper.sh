## Helper functions

# source additional files with extension $2 in $1
source_files_in_dir() {
	[ -d "$1" ] && \
		for f in "${1}"/*.${2}; do
			source "$f"
		done
}

source_files_in_dir `dirname ${BASH_SOURCE[0]}`/incl sh

## useful functions

# update these to your favoite apps:
viewpdf() {
	epdfview "$1" >& /dev/null
}
#

## eof vim: noet sta ts=4 sw=4
