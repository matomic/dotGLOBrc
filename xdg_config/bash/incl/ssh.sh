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

# test_ssh_auth_sock
# ====
# Test whether a socket file works
test_ssh_auth_sock () {
	if ! SSH_AUTH_SOCK=$1 ssh-add -l > /dev/null
	then
		local retval=$?;
		[[ $retval -eq 1 ]] && return 0;
		return $retval;
	fi
}

find_ssh_auth_sock() {
	for sock in $( find /tmp/ssh-* /tmp/com.apple.launchd.* "$@" -type s 2> /dev/null )
	do
		test_ssh_auth_sock $sock && ( \
			printf "SSH_AUTH_SOCK=$sock; export SSH_AUTH_SOCK\n"; return 0;
		)
	done
	return $?;
}
