# run_with_timeout
# ====
# Run a command with timeout
#
# run_with_timeout [10] cmd args...
#
function run_with_timeout() {
	local time=10
	if [[ $1 =~ ^[0-9]+$ ]]; then
		time=$1
		shift
	fi

	# Run in a subshell to avoid job control messages
	(
		"$@" &
		local child=$!
		# Avoid default notification in non-interactive shell for SIGTERM
		trap -- "" SIGTERM
		(
			sleep $time
			kill              $child 2> /dev/null 
		) &
		wait $child
	)
}
# vim: ft=zsh
