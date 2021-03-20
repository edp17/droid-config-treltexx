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

# get the current MAC address
var1=`ifconfig -a | grep wlan0`
var2=${var1:38}
var3=`echo "${var2//:}"`
var4=`echo "$var3" | tr '[:upper:]' '[:lower:]'`
cMac=`echo "$var4" | xargs`
echo "MAC address: $cMac"

echo $cMac > /wifi-mac
