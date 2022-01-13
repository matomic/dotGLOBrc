# sshdiff
# ====
# diff (possibly) with a file in remote host via ssh
#
# sshdiff [diffopts] remotehost:remotepath localpath
#
sshdiff () {
	local diffopts=()
	local remotehost=
	local remotepath=
	for arg in "$@"
	do
		if [[ "$arg" =~ : ]]
		then
			# argument with : is split into remotehost and remotepath values and replace with - (stdin)
			remotehost=${arg%%:*}
			remotepath=${arg#*:}
			diffopts+=(-)
		else
			diffopts+=("$arg")
		fi
		shift
	done
	ssh "$remotehost" cat "$remotepath" | diff "${diffopts[@]}"
}
