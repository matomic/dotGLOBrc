
## alias {{{
alias ll='ls -lh'
alias mv='mv -i'
alias rm='rm -I'
alias svi='sudo vi'
alias sshfs='sshfs -o follow_symlinks -o allow_root'
alias tmux='env TERM=screen-256color-bce tmux -2'
alias pdiff='diff -Naur'
alias rsync='rsync -e ssh'
alias fuck='sudo $(history -p \!\!)'

# lpr:
alias lpr_n2='lpr -o number-up=2'
alias lpr_tsle='lpr -o sides=two-sided-long-edge'
alias lpr_tsle_n2='lpr_n2 -o sides=two-sided-long-edge'
alias lpr_tsse='lpr -o sides=two-sided-short-edge'
alias lpr_tsse_n2='lpr_n2 -o sides=two-sided-short-edge'

[ x`which matlab 2>/dev/null` != x ] && alias matlab='env XMODIFIERS="" matlab'
[ x`which mathematica 2>/dev/null` != x ] && alias mathematica='env XMODIFIERS="" mathematica'
[ x`which mid3v2 2>/dev/null` != x ] && alias id3v2='mid3v2'

if [ $UID -eq 0 ];
then
	# makes emerge nicer on IO
	alias emerge='ionice -c3 emerge'
fi

# Ubuntu-centric
pkgbin=`which apt-get 2> /dev/null`
if [ "x$pkgbin" != "x" ]; then
	alias apt-search='apt-cache search --names-only'
	alias apt-policy='apt-cache policy'
	alias apt-install='sudo apt-get install'
	alias apt-installs='sudo apt-get install --install-suggests'
	alias apt-remove='sudo apt-get remove'
	alias apt-purge='sudo apt-get remove --purge'
	alias apt-autoremove='sudo apt-get autoremove'
	alias apt-autopurge='sudo apt-get autoremove --purge'
	alias apt-update='sudo apt-get update'
	alias apt-upgrade='sudo apt-get upgrade'
	alias apt-distupgrade='sudo apt-get dist-upgrade'
	alias apt-build-dep='sudo apt-get build-dep'
fi

# Gentoo-centric
pkgbin=`which ebuild 2> /dev/null`
if [ "x$pkgbin" != "x" ]; then
	alias vmconf='sudo vi /etc/make.conf'
	alias vmuse='sudo vi /etc/make.use.conf'
	alias vpuse='sudo vi /etc/portage/package.use'
	alias vpkws='sudo vi /etc/portage/package.keywords'
	alias vpumsk='sudo vi /etc/portage/package.unmask'
	alias vpmsk='sudo vi /etc/portage/package.mask'
fi

# Arch-centric
pkgbin=`which pacman 2> /dev/null`
if [ "x$pkgbin" != "x" ]; then
	alias pacin='sudo pacman -S'            # Install specific package(s) from the repositories
	alias pacind='sudo pacman -S --asdeps'  # Install given package(s) as dependencies of another package
	alias pacins='sudo pacman -U'           # Install specific package not from the repositories but from a file
	alias pacinsd='sudo pacman -U --asdeps' # Install specific package not from the repositories but from a file
	alias pacre='sudo pacman -R'            # Remove the specified package(s), retaining its configuration(s) and required dependencies
	alias pacrem='sudo pacman -Rns'         # Remove the specified package(s), its configuration(s) and unneeded dependencies
	alias pacrep='pacman -Si'               # Display information about a given package in the repositories
	alias pacreps='pacman -Ss'              # Search for package(s) in the repositories
	alias pacloc='pacman -Qi'               # Display information about a given package in the local database
	alias paclocs='pacman -Qs'              # Search for package(s) in the local database
	#
	alias pacupg='sudo pacman -Syu'                 # Synchronize with repositories before upgrading packages that are out of date on the local system.
	alias pacmir='sudo pacman -Syy'                 # Force refresh of all package lists after updating /etc/pacman.d/mirrorlis
	alias pacupd='sudo pacman -Sy && sudo abs'      # Update and refresh the local package and ABS databases against repositories
	alias pacdepc='sudo pacman -Rs $(pacman -Qtdq)' # Clean all unneeded dependencies
fi

### }}}

unset pkgbin

## vim: foldmethod=marker ft=sh noet sta ts=2 sw=2
