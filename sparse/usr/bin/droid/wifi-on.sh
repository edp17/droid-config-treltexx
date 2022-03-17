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

echo "turn-wifi.sh script - START"

  # Turn wifi off - just in case
  /usr/bin/connmanctl disable wifi
  sleep 2

  # Get default user name
  MYUSER=`getent passwd "100000" | cut -d: -f1`
  
  # wifi.conf location
  WIFICONFLOCATION="/usr/bin/droid/wifi.conf"
  
  . $WIFICONFLOCATION

  # Determine location of connman
  # From SFOS4.1 location has permanently changed to /home/defaultuser/.local/share/system/privileged/connman
  CONNMANPATH="/home/$MYUSER/.local/share/system/privileged/connman"

  # Clean $CONNMANPATH
  cd $CONNMANPATH
  rm -rf $CONNMANPATH/wifi*

  # Start wifi and get new wifi dir name
  /usr/bin/connmanctl enable wifi
  sleep 3

  newService=`/usr/bin/connmanctl services | grep "    $HOMENETWORKNAME"`
  newDir=${newService:25:54}
  echo "new: $newService"
  echo "newDir: $newDir"

  cd $CONNMANPATH

  /usr/bin/connmanctl disable wifi
  sleep 2
  echo "Wifi turned OFF"

  mkdir $CONNMANPATH/$newDir
  chmod 700 $CONNMANPATH/$newDir

  cp $CONNMANPATH/tmp_wifi/* $CONNMANPATH/$newDir/

  # update settings file in new wifi_* folder
  oldString="tmp_wifi"
  newString="["`echo "${newDir///}"`"]"
  sed -i "1s/.*/$newString/" $newDir/settings
  echo "Settings updated."

  /usr/bin/connmanctl enable wifi
  sleep 3
      
  pass=`cat $CONNMANPATH/$newDir/settings | grep Passphrase`
  if [ -z "$pass" ]
  then
    echo "Passphrase=$HOMENETWORKPASSWORD" >> $CONNMANPATH/$newDir/settings
  else
    echo "Passphrase is ok"
  fi
  
#  lastAddress=`cat $CONNMANPATH/$newDir/settings | grep IPv4.DHCP.LastAddress`
#  if [ -z "$lastAddress" ]
#  then
#    echo "IPv4.DHCP.LastAddress=$LASTADDRESS" >> $CONNMANPATH/$newDir/settings
#  else
#    echo "LastAddress is ok"
#  fi
  sleep 3
  
  echo "Wifi turned back ON"
  echo "Now connecting to wifi network"
  /usr/bin/connmanctl connect $newDir
  echo "Connected! You can start surfing on internet, enjoy! ;)"
  
echo "turn-wifi.sh script - DONE"
