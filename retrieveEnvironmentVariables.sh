#!/bin/bash

#This script will generate a file env.sh
#To use: bash getEnv.sh [path...]
#Please execute
# $ source env.sh
#to apply environment variables

ARGUMENTS="$@"
OUT_FILE="$(pwd)/env.sh"
echo '#!/bin/sh' > $OUT_FILE

# use for mac os
# SED_COMMAND='sed "s^\(.*\)\|\(.*\)^export \\1=\\2^"'
# SED_COMMAND="sed \"s^\|\(.*\)^='\\1'^\""
#use for aws linux
# SED_COMMAND="sed "s^\(.*\)|\(.*\)^export \\1=\\2^""
SED_COMMAND="sed \"s^|\(.*\)^='\\1'^\""

function exportToFile() {
	old_IFS=$IFS
	#set delimiter to only newline
	IFS=$'\n'
	for param in `jq -n "$1" | jq -r '.[].Value'`
	do
		#echo $param
		param=$(sed "s^'^'\\\''^" <<< $param) #escape all single quotes
		#echo $param
		param=`eval $SED_COMMAND <<< $param`
		echo "$param"
		echo $param >> $OUT_FILE
		# echo "echo $val" >> $OUT_FILE
	done
	#restore delimiter
	IFS=$old_IFS
}

for var in $ARGUMENTS
do
	PARAMSTORE=`aws ssm get-parameters-by-path --path "$var" --no-paginate --recursive | jq -r '.Parameters'`
	exportToFile "$PARAMSTORE"
done
