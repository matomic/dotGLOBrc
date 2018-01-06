#!/bin/bash
set +x
set -e

source deploy_helper.sh

pushd $(dirname "$0")

make deploy

# deploy fontconfig configurations
if [[ -d "${HOME}/.config/fontconfig" ]]
then
	deploy_if_diff "${HOME}/.config/fontconfig/fonts.conf" "fonts/fonts.conf.user"
fi

# deploy other configurations
deploy_if_diff "${HOME}/.tmux.conf" "tmux.conf"

popd

# eof vim: noet sw=4 ts=4
