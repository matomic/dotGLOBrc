## alias {{{

#alias sudo='sudo '

alias ll='ls -lh'
alias mv='mv -i'
if [[ ! $(uname) =~ Darwin ]]; then
	alias rm='rm -I'
fi
alias svi='sudo vi'
alias sshfs='sshfs -o follow_symlinks -o allow_root'
alias tmux='env TERM=screen-256color-bce tmux -2'
alias pdiff='diff -Naur'
alias rsync='rsync -e ssh'
alias lessr='less -R'
alias fuck='sudo $(history -p \!\!)'
alias xclip0='xclip -selection clipboard'

# lpr:
alias lpr_n2='lpr -o number-up=2'
alias lpr_tsle='lpr -o sides=two-sided-long-edge'
alias lpr_tsle_n2='lpr_n2 -o sides=two-sided-long-edge'
alias lpr_tsse='lpr -o sides=two-sided-short-edge'
alias lpr_tsse_n2='lpr_n2 -o sides=two-sided-short-edge'

[ matlab 2> /dev/null ] && alias matlab='env XMODIFIERS="" matlab'
[ mathematica 2> /dev/null ] && alias mathematica='env XMODIFIERS="" mathematica'
[ mid3v2 2> /dev/null ] && alias id3v2='mid3v2'

### }}}

## vim: foldmethod=marker ft=sh noet sta ts=2 sw=2
