#!/bin/sh
function deploy_if_diff {
if [ x !=  x`diff -q "${1}" "${2}"` ]
then
	cp -i "${1}" "${2}"
else
	printf "${1} and ${2} is identical.\n"
fi
}

DIR=$(dirname "$0")
deploy_if_diff ${DIR}/bash/bashrc.user      ${HOME}/.bashrc
deploy_if_diff ${DIR}/fonts/fonts.conf.user ${HOME}/.fonts.conf
deploy_if_diff ${DIR}/vim/vimrc.user        ${HOME}/.vimrc
deploy_if_diff ${DIR}/vim/gvimrc.user       ${HOME}/.gvimrc
