#!/bin/bash
# Author: Sean Reeves
# Date Created: 04/06/2018
# Date Modified:
# Description: A simple bash script to reconfigure svnserve.conf files for several repositories at once.
# License: MIT License
# Reference:
UUID=$(cat /proc/sys/kernel/random/uuid);
PWD=$(pwd);
FNAME=$(tempfile);
#[Sean Reeves] (04/06/2018) Comment: Create config file
echo "[general]\nanon-access=none\nauth-access=write\npassword-db=$PWD/passwd\nrealm=$UUID\n" >> "$FNAME";
#[Sean Reeves] (04/06/2018) Comment: Comment out any already existing lines, and add config lines to each file
find . -name "svnserve.conf" -exec sed -i.bak "s|^\([^#\s\t]\)|#\1|m" {} \; -exec sh -c "cat $FNAME >> {}" \;
#[Sean Reeves] (04/06/2018) Comment: Cleanup
rm $FNAME;
