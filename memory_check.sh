#!/bin/bash

#Install bc first
#sudo yum install bc

usage() {
	echo "./memory_check -c [persentage] -w [percentage] -e [email address]"
	echo "-c - critical threshold in percentage"
	echo "-w - warning threshold in percentage"
	echo "-e - emaila address to send the report"
	echo "critical threshold should be greater than warning threshold"
	exit 5
}

#get the arguments
while getopts "c:w:e:" args ; do
	case "${args}" in
		c)
			critical=${OPTARG}
			;;
		w)
			warning=${OPTARG}
			;;
		e)
			email=${OPTARG}
			;;
		*)
			usage
			;;
	esac
done

#check if parameters are correct
if [ -z "${critical}" ] || [ -z "${warning}" ] || [ -z "${email}" ] || [ "${warning}" -ge "${critical}" ]; then
	usage
fi

TOTAL_MEMORY=$( free | grep Mem: | awk '{ print $2 }' )
USED_MEMORY=$( free | grep Mem| awk '{ print $3 }' )
PERCENTAGE=$(echo "scale=2; $USED_MEMORY/$TOTAL_MEMORY" | bc)
PERCENTAGE=${PERCENTAGE:1:2}

echo $PERCENTAGE

