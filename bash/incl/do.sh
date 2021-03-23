echodo () {
	echo "$*"
	"$@"
}

seqdo() {
	# seqdo seq_args -- cmd
	# Run $cmd with string '##' substituted with numerical sequence generated by seq $seq_args
	local seq_cmd='seq'
	while [[ -n "$1" && "$1" != "--" ]]
	do
		seq_cmd+=" $1"
		shift
	done
	shift # --
	#while [[ -n "$*" ]]
	#do
	#	local arg=$1
	#	if [[ -n ${last_is_number} ]]
	#	then
	#		if [[ ! ${arg} =~ [0-9]+ ]] # not a number
	#		then
	#			break
	#		fi
	#	fi
	#	seq_cmd+=" ${arg}"
	#	if [[ ${arg} =~ [0-9]+ ]]
	#	then
	#		local last_is_number=1
	#	fi
	#	shift
	#done
	for x in $(${seq_cmd})
	do
		echodo `echo $* | sed -e 's,##,'${x}',g'`
	done
}
