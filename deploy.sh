#!/bin/sh

deploy_if_diff() {
	diff -uN "${2}" "${1}" || cp -i "${1}" "${2}"
}

DIR=$(dirname "$0")

deploy_if_diff "${DIR}/bash/bashrc.user"      "${HOME}/.bashrc"
deploy_if_diff "${DIR}/fonts/fonts.conf.user" "${HOME}/.fonts.conf"
deploy_if_diff "${DIR}/vim/vimrc.user"        "${HOME}/.vimrc"
deploy_if_diff "${DIR}/vim/gvimrc.user"       "${HOME}/.gvimrc"
