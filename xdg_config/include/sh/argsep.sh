# argsep
# ====
# print the position of argument separator
#
# e.g.
# > argsep foo -- bar
# 2
# > argsep foo bar
# 3
#
# returns 0
function argsep() {
	local pos=1
	for arg in "$@"
	do
		[[ "$arg" == "--" ]] && break;
		pos=$(( $pos + 1 ))
	done
	printf "$pos"
}
# vim: ft=zsh
