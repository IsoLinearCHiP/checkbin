#!/bin/bash

### verify a snapshot

## verify snapshot_file

## shows the differences of the current filesystem to the snapshot

file=$1

head -n6 $file | while read name value; do
	case $name in
		root_path:)
			root_path=$value
			;;
		grepre:)
			grepre=$value
			;;
	esac
done

tail -n +7 $file | while read line; do
	file=$(echo "$line" | cut -f9)
	echo -n "checking $file ... "
	{ 
		./fingerprint.sh $file ; 
		echo "$line" ;
	} | ./fpcompare.sh
	res=$?
	[[ $res -eq 0 ]] && echo "OK"
done
