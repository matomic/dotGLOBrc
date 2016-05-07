#!/bin/sh
set -x
set -e

DIFF=`which colordiff || which diff`
deploy_if_diff() {
  ${DIFF} -uN "${2}" "${1}" || true
  if [ -n "`diff -qN \"${2}\" \"${1}\"`" ];
  then
    cp -i -L "${1}" "${2}"
  fi
}

pushd $(dirname "$0")

mkdir -p ${HOME}/.vim

deploy_if_diff "bash/bashrc.user" "${HOME}/.bashrc"
deploy_if_diff "vim/vimrc.user"   "${HOME}/.vim/vimrc"
deploy_if_diff "vim/vimrc.local"  "${HOME}/.vim/vimrc.local"
rsync -av --delete vim/*.vim ${HOME}/.vim/
[[ -f ${HOME}/.vimrc ]] || ln -s .vim/vimrc ${HOME}/.vimrc

#deploy_if_diff "vim/gvimrc.user"       "${HOME}/.gvimrc"
if [ -d "${HOME}/.config/fontconfig/" ]
then
  deploy_if_diff "fonts/fonts.conf.user" "${HOME}/.config/fontconfig/fonts.conf"
fi

rsync -av --delete "vim/bundle/" ${HOME}/.vim/bundle/

popd
