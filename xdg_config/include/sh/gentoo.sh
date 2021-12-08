# Gentoo-centric
which ebuild > /dev/null 2>&1 || return

vmconf(){
sudo ${EDITOR} /etc/make.conf "$@"
}
vmuse(){
sudo  ${EDITOR}/etc/make.use.conf "$@"
}
vpuse(){
sudo  ${EDITOR}/etc/portage/package.use "$@"
}
vpkws(){
sudo  ${EDITOR}/etc/portage/package.keywords "$@"
}
vpumsk(){
sudo ${EDITOR} /etc/portage/package.unmask "$@"
}
vpmsk(){
sudo  ${EDITOR}/etc/portage/package.mask "$@"
}
[ $UID -eq 0 ] || return

# makes emerge nicer on IO
emerge(){
ionice -c3 emerge "$@"
}
