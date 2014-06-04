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

DIR=$(dirname "$0")

deploy_if_diff "${DIR}/bash/bashrc.user"      "${HOME}/.bashrc"
deploy_if_diff "${DIR}/fonts/fonts.conf.user" "${HOME}/.config/fontconfig/fonts.conf"
deploy_if_diff "${DIR}/vim/vimrc.user"        "${HOME}/.vim/vimrc"
#deploy_if_diff "${DIR}/vim/gvimrc.user"       "${HOME}/.gvimrc"

rsync -av "${DIR}/vim/bundle/" ${HOME}/.vim/bundle/
