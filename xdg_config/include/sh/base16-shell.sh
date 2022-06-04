
BASE16_SHELL=${1:-${BASHRC_DIR}}/modules/base16-shell/

colortest_base16 () {
		${BASE16_SHELL}/colortest "$@"
}

init_base16() {
[ -n "$PS1" ] && \
	[ -s $BASE16_SHELL/profile_helper.sh ] && \
	eval "` $BASE16_SHELL/profile_helper.sh `"
}
