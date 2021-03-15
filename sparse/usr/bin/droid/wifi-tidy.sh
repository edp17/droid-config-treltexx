#!/bin/bash

cd $HOME/.local/share/system/privileged/connman/
dirCount=`ls -l | grep wifi | grep -c ^d`

# if more than 1 wifi* directory, remove them
if [ $dirCount != "1" ]
then
echo "Cleaning $HOME/.local/share/system/privileged/connman/..."
rm -rf $HOME/.local/share/system/privileged/connman/wifi*
fi
echo "done"
