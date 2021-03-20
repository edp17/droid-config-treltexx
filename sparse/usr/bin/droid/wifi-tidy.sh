#!/bin/bash

#      Copyright (C) 2020 edp17
#
#  This Program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2, or (at your option)
#  any later version.
#
#  This Program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
#  GNU General Public License for more details.
#

# Get default user name
MYUSER=`getent passwd "100000" | cut -d: -f1`

# Determine location of connman
CONNMANPATH="/home/.system/var/lib/connman"
if [ "$MYUSER" = "defaultuser" ]
then
  CONNMANPATH="/home/$MYUSER/.local/share/system/privileged/connman"
fi

cd $CONNMANPATH
dirCount=`ls -l | grep wifi | grep -c ^d`

# if more than 1 wifi* directory, remove them
if [ $dirCount != "1" ]
then
echo "Cleaning $CONNMANPATH/..."
rm -rf $CONNMANPATH/wifi*
fi
echo "done"
