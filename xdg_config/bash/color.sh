# ANSI color codes {{{
usecolor()  {
	if [ $(uname) = "Darwin" ]; then # OSX is not very nice...
		export CLICOLOR=1
		return
	fi

	if [ $(tput colors) -ge 16 ]; then
		return
	fi

	# Set colorful PS1 only on colorful terminals.
	# dircolors --print-database uses its own built-in database
	# instead of using /etc/DIR_COLORS.  Try to use the external file
	# first to take advantage of user additions.  Use internal bash
	# globbing instead of external grep binary.
	local safe_term=${TERM//[^[:alnum:]]/?} # sanitize TERM
	local match_lhs=""
	[ -f ~/.dir_colors ] && match_lhs="${match_lhs}$(< ~/.dir_colors)"
	[ -f /etc/DIR_COLORS ] && match_lhs="${match_lhs}$(< /etc/DIR_COLORS)"
	[ -z ${match_lhs}  ] &&
		type  -P dircolors > /dev/null &&
		match_lhs=$( dircolors --print-database | grep TERM)
	[[ $'\n'${match_lhs} = *$'\n'"TERM "${safe_term}* ]] && return

	return 1
}

function loadANSIcolor {
	FGCBLK='[30m' # Black - Foreground
	FGCRED='[31m' # Red
	FGCGRN='[32m' # Green
	FGCYLW='[33m' # Yellow
	FGCBLU='[34m' # Blue
	FGCPUR='[35m' # Purple
	FGCCYN='[36m' # Cyan
	FGCWHT='[37m' # White
	BGCBLK='[40m' # Black - Background
	BGCRED='[41m' # Red
	BGCGRN='[42m' # Green
	BGCYLW='[43m' # Yellow
	BGCBLU='[44m' # Blue
	BGCPUR='[45m' # Purple
	BGCCYN='[46m' # Cyan
	BGCWHT='[47m' # White
	TXTRST='[0m' # Text Reset
	TXTBLD='[1m' # Bold type
	TXTUND='[4m' # underline
	TXTINV='[7m' # Revert fg and bg color
}
# }}}

## Colorful settings {{{
source $(dirname ${BASH_SOURCE[0]})/base16-shell.sh

if usecolor; then
	init_base16

	loadANSIcolor

	if [ -z "${PROMP_COMMAND}" ]; then
		PS1_USER="\[$TXTINV\]\[$TXTBLD\]\[$FGCGRN\]\u◗\[$TXTRST\]"
		PS1_HOST="\[$TXTINV\]\[$TXTBLD\]\[$FGCBLU\]\h◗\[$TXTRST\]"
		PS1_CWDR="\[$TXTBLD\]\[$FGCRED\]\W▸\[$TXTRST\]"
		PS1_PRM1="\[$TXTBLD\]λ\[$TXTRST\] "
		PS1_PRM2="\[$TXTBLD\]#\[$TXTRST\] "
		if [ ! ${EUID} = "0" ]; then
			PS1="$PS1_USER$PS1_HOST$PS1_CWDR$PS1_PRM1"
			#PS1="\[$TXTINV\]\[$TXTBLD\]\[$FGCRED\]\u▸\[$FGCBLU\]\h▸\[$TXTRST\]\[$FGCGRN\]\w▸\[$TXTRST\]\[$TXTBLD\]λ\[$TXTRST\] "
		else
			PS1="$PS1_USER$PS1_HOST$PS1_CWDR$PS1_PRM2"
			#PS1="\[$TXTINV\]\[$TXTBLD\]\[$FGCRED\]\h\[$FGCPUR\]\u\[$TXTRST\]\[$FGCGRN\]◖\w◗\[$TXTRST\]\[$TXTBLD\]#\[$TXTRST\] "
		fi

		if ls --color >&/dev/null; then
			alias ls='ls --color=auto'
		else
			alias ls='ls -G'
		fi
	fi
else
	if [[ ${EUID} == 0 ]]; then
		# show root@ when we don't have colors
		PS1='\u@\h \W \$ '
	#else
	#	PS1='\u@\h \w \$ '
	fi
fi

PS2="> $RS"
## }}}

# base16_material-darker
base16_summerfruit-dark

## vim: foldmethod=marker ft=sh noet sta ts=2 sw=2
