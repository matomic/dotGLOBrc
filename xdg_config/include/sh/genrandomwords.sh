# genrandomwords
# ====
# Generate random words
genrandomwords() {
	local w_regexp=^[a-z]{4,7}$
	local w=$(egrep "$w_regexp" /usr/share/dict/words | wc -l)
	local c=5
	[ -n "${1+1}" ] && c="$1"
	for i in $(seq $c); do
		egrep "$w_regexp" /usr/share/dict/words | sed -n "$((RANDOM % w + 1)) p"
	done
}
