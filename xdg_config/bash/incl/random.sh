# generates a random integer
random() {
	dd if=/dev/urandom count=1 2> /dev/null | cksum | cut -f1 -d" "
}

# generates random password
genpasswd() {
	local l=$1
	[ -z "$l" ] && l=20
	LC_ALL=C tr -dc A-Za-z0-9_ < /dev/urandom | head -c ${l} | xargs
}

genrandomwords() {
	local w=`egrep "^[a-z]{4,7}$" /usr/share/dict/words | wc -l`
	local c=5
	if [ ! "x$1" = "x" ]; then c="$1"; fi
	for i in `seq $c`; do
		egrep "^[a-z]{4,7}$" /usr/share/dict/words | sed -n "$((RANDOM % w + 1)) p"
	done
}
