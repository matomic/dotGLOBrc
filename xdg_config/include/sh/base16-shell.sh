BASE16_SHELL=${1:-${BASHRC_DIR}}/modules/base16-shell/

colortest_base16() {
	${BASE16_SHELL}/colortest "$@"
}

init_base16() {
	[ -n "$PS1" ] &&
		[ -s "$BASE16_SHELL/profile_helper.sh" ] &&
		source "$BASE16_SHELL/profile_helper.sh"
}

reset_theme_base16() {
	local theme=${1:-${BASE16_THEME}}
	local script="${BASE16_SHELL}/scripts/base16-${theme}.sh"
	if declare -f _base16 > /dev/null && [ -f "${script}" ]; then
		set -x
		_base16 "${script}" "${theme}"
		set -x
	fi
}
