#!/bin/bash

### generate a snapshot

## snapshot [-x regex] [-X filename] root_path

## -x regex : exclude files/folders that match this regex, can be listed multiple times
## -X filename : specify a file from which to read regexes line by line which should be excluded
## the search is started from root_path .


declare -a Excludes
i=0

while [[ true ]]; do
	if [[ $1 == "-x" ]]; then
		regex=$2
		shift 2
		Excludes[i]=$regex
		i=$(( $i + 1 ))
		if [[ -z $grepre ]]; then
			grepre=$regex
		else
			grepre="${grepre}\|${regex}"
		fi
	elif [[ $1 == "-X" ]]; then
		filename=$2
		shift 2
		## FIXME: silently ignored atm, but should read the file later
	else
		root_path=$1
		break
	fi
done

[[ -z $grepre ]] && grepre="^$"

echo "Version: 1"
echo "Date: $(date --rfc-3339=seconds)"
echo "root_path: $root_path"
echo "Excludes: ${Excludes[@]}"
echo "grepre: $grepre"
echo ""
find $root_path | grep -v $grepre | xargs -L 1 ./fingerprint.sh