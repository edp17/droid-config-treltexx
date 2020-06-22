#!/bin/bash

# get the current MAC address
var1=`ifconfig -a | grep wlan0`
var2=${var1:38}
var3=`echo "${var2//:}"`
var4=`echo "$var3" | tr '[:upper:]' '[:lower:]'`
cMac=`echo "$var4" | xargs`
echo "MAC address: $cMac"

echo $cMac > /wifi-mac
