#!/bin/bash

### generate fingerprint for file in argument one

FILE=$1

## Filetype, accessrights(octal), uid, gid, size, changed time, modified time
STAT=$(stat --printf="%f\t%a\t%u\t%g\t%s\t%z\t%y" $FILE)

HASH=$([[ ! -d $FILE ]] && ( sha1sum $FILE | cut -d' ' -f1 ) || echo '-' )

echo -e "$STAT\t$HASH\t$FILE"