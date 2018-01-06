#!/bin/bash

_deploy_if_diff() {
	# deploy a single file to destination.  If target file exists, check for
	# diff.  If difference, call merge tool
	local fr=$1;
	local to=$2;

	local diff=${DIFF:=`which colordiff || which diff`}
	local merge=${MERGE:=vimdiff}

	if [[ -d "${to}" ]]
	then
		printf "deploy_if_diff ${fr}\t${to}/\n"
		local to=${to}/`basename ${fr}`
	else
		printf "deploy_if_diff ${fr}\t${to}\n"
	fi

	if ! ${diff} -quN "${to}" "${fr}"
	then
		if which ${merge}
		then
			${merge} "${to}" "${fr}"
		else
			${diff} -uN "${to}" "${fr}"
		fi
	fi
	if ${diff} -quN "${to}" "${fr}"
	then
		printf "~ ${fr} and ${to} are the same\n"
	else
		cp -i -L "${fr}" "${to}"
		printf "! overwriting ${to} with ${fr}"
	fi
}

deploy_if_diff () {
	local to=$1
	shift
	# TODO: if len($@) > 1, assert to is directory
	for f in "$@"
	do
		if [[ -f "$f" ]]
		then
			_deploy_if_diff "$f" "$to"
		fi
	done
}

# eof vim: noet sw=4 ts=4
