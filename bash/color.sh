
# ANSI color codes {{{
usecolor () {
	use_color=false

	# Set colorful PS1 only on colorful terminals.
	# dircolors --print-database uses its own built-in database
	# instead of using /etc/DIR_COLORS.  Try to use the external file
	# first to take advantage of user additions.  Use internal bash
	# globbing instead of external grep binary.
	safe_term=${TERM//[^[:alnum:]]/?}   # sanitize TERM
	local match_lhs=""
	[[ -f ~/.dir_colors   ]] && match_lhs="${match_lhs}$(<~/.dir_colors)"
	[[ -f /etc/DIR_COLORS ]] && match_lhs="${match_lhs}$(</etc/DIR_COLORS)"
	[[ -z ${match_lhs}    ]] \
		&& type -P dircolors >/dev/null \
		&& match_lhs=$(dircolors --print-database | grep TERM)
	[[ $'\n'${match_lhs} == *$'\n'"TERM "${safe_term}* ]] && use_color=true

	if [[ $(uname) == "Darwin" ]] # OSX is not very nice...
 	then
		use_color=true
		export CLICOLOR=1
	fi
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
	TXTRST='[0m'  # Text Reset
	TXTBLD='[1m'  # Bold type
	TXTUND='[4m'  # underline
	TXTINV='[7m'  # Revert fg and bg color
}
# }}}

## Colorful settings {{{
usecolor

BASE16_DIR=${HOME}/.bashrc.d/modules/base16-shell/
colorscheme_base16 () {
	if [[ -z "$*" ]]
	then
		pushd ${BASE16_DIR} > /dev/null
		ls base16-*.sh
		popd > /dev/null
	else
		local f="${BASE16_DIR}/base16-$1.${2:-dark}.sh"
		[[ -s $f ]] && source $f || echo "Unknown color scheme: $1"
	fi
}

colortest_base16 () {
		${BASE16_DIR}/colortest $*
}

if ${use_color}; then
	loadANSIcolor
	colorscheme_base16 colors

	if [ ! ${EUID} = "0" ]; then
		PS1="\[$TXTBLD\]\[$FGCRED\]\h:\[$FGCPUR\]\W \[$FGCGRN\]\u\[$TXTRST\]\\$ "
	else
		PS1="\[$TXTBLD\]\[$FGCRED\]\u@\[$FGCPUR\]\h:\[$FGCGRN\]\W\[$TXTRST\] # "
	fi

	if ls --color >& /dev/null; then
		alias ls='ls --color=auto';
	else
		alias ls='ls -G';
	fi
else
	if [[ ${EUID} == 0 ]] ; then
		# show root@ when we don't have colors
		PS1='\u@\h \W \$ '
	#else
	#	PS1='\u@\h \w \$ '
	fi
fi

PS2="> $RS"
## }}}

# Try to keep environment pollution down, EPA loves us.
unset use_color safe_term match_lhs

## vim: foldmethod=marker ft=sh noet sta ts=2 sw=2
