sshdiff () {
	# sshdiff ${diffopts} remote:path localpath
	local diffopts=""
	local remotehost=""
	local remotepath=""
	while [[ -n "$1" ]]
	do
		if [[ "$1" =~ : ]]
		then
			# split by :
			remotehost=${1%%:*}
			remotepath=${1#*:}
			diffopts+=" -"
		else
			diffopts+=" $1"
		fi
		shift
	done
	ssh "$remotehost" cat "$remotepath" | diff ${diffopts}
}
