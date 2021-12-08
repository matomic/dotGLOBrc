#!/bin/sh
# numerically sort /etc/passwd by UID
sort_uid() {
	cp -f "$1" "$1"~
	sort -n -t: +2 "$1" > "$1".1
	cp -i "$1".1 "$1"
}

sort_uid "$@"
