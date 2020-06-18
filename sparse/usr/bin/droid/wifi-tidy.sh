#!/bin/bash

cd /home/.system/var/lib/connman/
dirCount=`ls -l | grep wifi | grep -c ^d`

# if more than 1 wifi* directory, remove them
if [ $dirCount != "1" ]
then
echo "Cleaning /home/.system/var/lib/connman..."
rm -rf /home/.system/var/lib/connman/wifi*
fi
echo "done"
