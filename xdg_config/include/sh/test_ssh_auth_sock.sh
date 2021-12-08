#
# test_ssh_auth_sock
# ====
# Test whether a socket file is feom a valid ssh-agent process
#
# e.g.
# > test_ssh_auth_sock /tmp/com.apple.launchd.G9r6dLT2nV/Listeners
#
# return 0 if success, otherwise the return code of ssh-add
test_ssh_auth_sock () {
	if ! SSH_AUTH_SOCK=$1 ssh-add -l > /dev/null
	then
		local retval=$?;
		[[ $retval -eq 1 ]] && return 0;
		return $retval;
	fi
}
# vim: ft=zsh
