#!/bin/bash
set +x
set -e

DIFF=`which colordiff || which diff`
deploy_if_diff() {
  local fr=$1;
  local to=$2;
  if [[ -d "${to}" ]]
  then
    local to=${to}/`basename ${fr}`
  fi
  ${DIFF} -uN "${to}" "${fr}" || true
  if [[ -n `diff -qN "${to}" "${fr}"` ]];
  then
    cp -i -L "${fr}" "${to}"
  fi
}

pushd $(dirname "$0")

mkdir -p ${HOME}/.bashrc.d/modules
rsync -av bash/modules/ ${HOME}/.bashrc.d/modules/
for f in bash/*
do
  [[ -f $f ]] && deploy_if_diff $f ${HOME}/.bashrc.d
done
[[ -f ${HOME}/.bashrc ]] || ln -s .bashrc.d/bashrc.user ${HOME}/.bashrc

mkdir -p ${HOME}/.vim
deploy_if_diff "vim/vimrc.user"   "${HOME}/.vim/vimrc"
deploy_if_diff "vim/vimrc.local"  "${HOME}/.vim/vimrc.local"
rsync -av --delete vim/*.vim ${HOME}/.vim/
[[ -f ${HOME}/.vimrc ]] || ln -s .vim/vimrc ${HOME}/.vimrc

#deploy_if_diff "vim/gvimrc.user"       "${HOME}/.gvimrc"
if [[ -d "${HOME}/.config/fontconfig" ]]
then
  deploy_if_diff "fonts/fonts.conf.user" "${HOME}/.config/fontconfig/fonts.conf"
fi

rsync -av --delete "vim/bundle/" ${HOME}/.vim/bundle/

popd
