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

echo "wifi-fix.sh script - START"
cd $CONNMANPATH
dirCount=`ls -l | grep wifi | grep -c ^d`

# if more than 1 wifi* directory, remove them
if [ $dirCount != "1" ]
then
  echo "More wifi* directories - removing all"
  rm -rf $CONNMANPATH/wifi*
  echo "Switching wifi off"
  /usr/bin/connmanctl disable wifi
  echo "Wifi is off"
  echo "Please toggle the wifi on again and enter the password!"
else
  # $CONNMANPATH directory is clean
  # proceeding with preparation for turning the wifi on
  wifiStatusWas="off"
  # get wifi status
  #wvar1=`/usr/bin/connmanctl state | grep State`
  #wvar2=${wvar1:9}
  wStatus=`cat /wifi-prev-status | xargs`

  # echo "Wifi status: $wStatus"

  # if wifi is on, switch it off
  if [ $wStatus = "online" ]
  then
  wifiStatusWas="on"
  /usr/bin/connmanctl disable wifi
  # echo "Wifi turned OFF"
  fi

  # get the current MAC address
  #var1=`ifconfig -a | grep wlan0`
  #var2=${var1:38}
  #var3=`echo "${var2//:}"`
  #var4=`echo "$var3" | tr '[:upper:]' '[:lower:]'`
  #cMac=`echo "$var4" | xargs`
  cMac=`cat /wifi-mac | xargs`
  echo "MAC address: $cMac"

  # create wifi_*_managed_psk dir in $CONNMANPATH
  cd $CONNMANPATH
  oldDir=`ls -d */ | grep wifi`
  oldDirLastBit=${oldDir:17}
  dirFirst='wifi_'
  newDir="$dirFirst$cMac$oldDirLastBit"
  all='*'
  oldDirPath="$oldDir$all"

  # create new tmp folder
  mkdir wifi_tmp
  chmod 700 wifi_tmp

  # copy content from old to new wifi_* folder
  cp $oldDirPath wifi_tmp/

  # remove the old wifi_ folder
  rm -f $oldDirPath
  rmdir $oldDir

  # update settings file in new wifi_* folder
  oldString="["`echo "${oldDir///}"`"]"
  newString="["`echo "${newDir///}"`"]"
  sed -i "1s/.*/$newString/" wifi_tmp/settings
  # echo "Settings updated."

  # rename tmp folder to new wifi_ folder
  mv wifi_tmp $newDir
  # echo "$newDir created"

  if [ $wifiStatusWas = "on" ]
  then
  /usr/bin/connmanctl enable wifi
  # echo "Wifi turned back ON"
  fi
fi
echo "wifi-fix.sh script - DONE"
