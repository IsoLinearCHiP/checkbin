#!/bin/bash

### compare fingerprints and set the exit code

## -t ignore timestamps

IGNTS=0
[[ $1 == "-t" ]] && IGNTS=1

OLDIFS=$IFS
IFS=$'\t'
read ftype1 perm1 uid1 gid1 size1 ctime1 mtime1 hash1 fname1
read ftype2 perm2 uid2 gid2 size2 ctime2 mtime2 hash2 fname2
IFS=$OLDIFS

# echo "$fname1, $fname2 ."
if [[ $ftype1 != $ftype2 ]]; then
	echo "mismatch in ftype"
	# echo "$ftype1, $ftype2 ."
	exit 1
fi

if [[ $perm1 != $perm2 ]]; then
	echo "mismatch in perms"
	exit 1
fi

if [[ $uid1 != $uid2 ]]; then
	echo "mismatch in uid"
	exit 1
fi

if [[ $gid1 != $gid2 ]]; then
	echo "mismatch in gid"
	exit 1
fi

if [[ $size1 != $size2 ]]; then
	echo "mismatch in size"
	exit 1
fi

if [[ $IGNTS -eq 0 ]]; then
	if [[ $ctime1 != $ctime2 ]]; then
		echo "mismatch in ctime"
		exit 1
	fi

	if [[ $mtime1 != $mtime2 ]]; then
		echo "mismatch in mtime"
		exit 1
	fi
fi

if [[ $hash1 != $hash2 ]]; then
	echo "mismatch in hash"
	exit 1
fi

