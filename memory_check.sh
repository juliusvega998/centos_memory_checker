#!/bin/bash

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

echo "critical = ${critical}"
echo "warning = ${warning}"
echo "email = ${email}"

#check if parameters are correct. if not, returns error code 5
if [ -z "${critical}" ] || [ -z "${warning}" ] || [ -z "${email}" ] || [ "${warning}" -ge "${critical}" ]; then
	usage
fi

