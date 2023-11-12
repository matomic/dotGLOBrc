# seqdo
# ====
# Performs cmd with argument substituion '##' to sequence value
#
# seqdo [seq_args] -- cmd [args...]
# where seq_args are arguments to seq
#
# requires argsep
#
# exits when the first command in sequence fails
# returns the status code of the last ran cmd
function seqdo() {
	local pos=$(argsep "$@")
	for x in $(seq ${@:1:$(($pos - 1))}); do
		local cmdline=()
		for arg in "${@:$(($pos + 1))}"; do
			cmdline+=(${arg/\#\#/$x})
		done
		$cmdline || return $?
	done
}
# vim: ft=zsh
