# generates a random integer
genpasswd() {
	local l=$1
	[ -z "$l" ] && l=20
	LC_ALL=C tr -dc A-Za-z0-9_ < /dev/urandom | head -c ${l}
}
# vim: ft=bash
