#!/bin/sh
DIR=$(dirname "$0")
cp -i ${DIR}/bash/bashrc.user      ${HOME}/.bashrc
cp -i ${DIR}/fonts/fonts.conf.user ${HOME}/.fonts.conf
cp -i ${DIR}/vim/vimrc.user        ${HOME}/.vimrc
cp -i ${DIR}/vim/gvimrc.user       ${HOME}/.gvimrc
