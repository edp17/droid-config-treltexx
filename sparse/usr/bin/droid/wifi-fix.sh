#!/bin/bash

wifiStatusWas="off"
# get wifi status
#wvar1=`/usr/bin/connmanctl state | grep State`
#wvar2=${wvar1:9}
wStatus=`cat /wifi-prev-status | xargs`

echo "Wifi status: $wStatus"

# if wifi is on, switch it off
if [ $wStatus = "online" ]
then
wifiStatusWas="on"
/usr/bin/connmanctl disable wifi
echo "Wifi turned OFF"
fi

# get the current MAC address
var1=`ifconfig -a | grep wlan0`
var2=${var1:38}
var3=`echo "${var2//:}"`
var4=`echo "$var3" | tr '[:upper:]' '[:lower:]'`
cMac=`echo "$var4" | xargs`
echo "MAC address: $cMac"

# create wifi_*_managed_psk dir in /home/.system/var/lib/connman/
cd /home/.system/var/lib/connman/
oldDir=`ls -d */ | grep wifi`
oldDirLastBit=${oldDir:17}
dirFirst='wifi_'
newDir="$dirFirst$cMac$oldDirLastBit"
all='*'
oldDirPath="$oldDir$all"

# create new tmp folder
mkdir edp17_tmp
chmod 700 edp17_tmp

# copy content from old to new wifi_* folder
cp $oldDirPath edp17_tmp/

# remove the old wifi_ folder
rm -f $oldDirPath
rmdir $oldDir

# update settings file in new wifi_* folder
oldString="["`echo "${oldDir///}"`"]"
newString="["`echo "${newDir///}"`"]"
sed -i "1s/.*/$newString/" edp17_tmp/settings
echo "Settings updated."

# rename tmp folder to new wifi_ folder
mv edp17_tmp $newDir
echo "$newDir created"

if [ $wifiStatusWas = "on" ]
then
/usr/bin/connmanctl enable wifi
echo "Wifi turned back ON"
fi

echo "wifi-fix.sh script done."
