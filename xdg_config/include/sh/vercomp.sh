#!/usr/bin/env sh

# version string compare
# return 1 if $1 > $2
# return -1 if $2 > $1
# return 0 if equal
vercomp()  {
	if [ x"$1" = x"$2" ]; then
		printf "0"
		return
	fi

	local pre1=${1%%.*} pre2=${2%%.*}
	if [ "${pre1}" -gt "${pre2}" ]; then
		printf "1"
		return           0
	fi
	if [ "${pre1}" -lt "${pre2}" ]; then
		printf "2"
		return           0
	fi
	if [ "${pre1}" -eq "${pre2}" ]; then
		local post1=${1#${pre1}.} post2=${2#${pre2}.}
		b=$(vercomp "${post1}" "${post2}")
		printf "${b}"
		return              0
	fi
	return 1 # exit with error, usually due to non-numeric $1 or $2
}
