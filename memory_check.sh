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

#gets the total memory and used memory
total=$( free | grep Mem: | awk '{ print $2 }' )
used=$( free | grep Mem: | awk '{ print $3 }' )
percentage=$(echo "scale=2; $used/$total" | bc)
percentage=${percentage:1:2}

if [ "${percentage}" -ge "${critical}" ]; then
	echo "Memory is at critical level."
	exit 2
elif [ "${percentage}" -ge "${warning}" ]; then
	echo "Memory is at warning level."
	exit 1
else
	echo "Memory is at normal level."
	exit 0
fi


