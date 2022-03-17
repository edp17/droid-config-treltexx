#!/bin/bash

#      Copyright (C) 2021 edp17
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

MYUSER=`getent passwd "100000" | cut -d: -f1`

WDHOME="/home/waydroid"
DESKTOPICON="/home/$MYUSER/.local/share/applications/Waydroid.desktop"
GAPPSICON="Icon=/opt/waydroid/data/AppIconGapps.png"
VANILLAICON="Icon=/opt/waydroid/data/AppIcon.png"

if [[ $1 = "vanilla" ]]; then
  FLAVOUR="VANILLA"
else
  FLAVOUR="GAPPS"
fi

if [[ $1 != "" ]]; then
#========== STOP WAYDROID =========================
  # Stop session
  echo "$FLAVOUR => Stopping Waydroid Session..."
  waydroid session stop
  sleep 1
  if ps ax | grep -v grep | grep "waydroid session" > /dev/null
  then
    echo "$FLAVOUR => Waydroid Session didn't stop. Try again."
    exit 1
  else
    echo "$FLAVOUR => Waydroid Session stopped."
  fi
  sleep 1
  echo ""
  
  # Stop container
  echo "$FLAVOUR => Stopping Waydroid Container..."
  sudo waydroid container stop
  sleep 1
  echo "$FLAVOUR => Waydroid Container stopped."
  echo ""
  
#  echo "$FLAVOUR => Stop Waydroid Sensors..."
#  if ps ax | grep -v grep | grep waydroid-sensord > /dev/null
#  then
#    sudo kill `pgrep waydroid-sensord`
#  fi
#  echo "$FLAVOUR => Waydroid Sensors stopped."
#  echo ""

#========== UNLINK SYSTEM & DATA =========================
  # Prepare system.img and user data
  echo "$FLAVOUR => Preparing system.img and user data..."
  echo "$FLAVOUR => Unlinking system.img..."
  sudo unlink $WDHOME/images/system.img
  if [ -f "$WDHOME/images/system.img" ]; then
    echo "$FLAVOUR => Unlinking system.img failed. Try again."
    exit 1
  else 
    echo "$FLAVOUR => system.img unlinked."
  fi
  echo ""

  echo "$FLAVOUR => Unlinking user data..."
  unlink /home/$MYUSER/.local/share/waydroid
  if [ -d "/home/$MYUSER/.local/share/waydroid" ]; then
    echo "$FLAVOUR => Unlinking user data failed. Try again."
    exit 1
  else 
    echo "$FLAVOUR => User data unlinked."
  fi
  echo ""

#========== LINK SYSTEM & DATA =========================
  echo "$FLAVOUR => Linking user data..."
  if [[ $1 = "vanilla" ]]; then
    echo "$FLAVOUR => Linking VANILLA..."
    ln -s /home/$MYUSER/waydroid-vanilla /home/$MYUSER/.local/share/waydroid
  else
    echo "$FLAVOUR => Linking GAPPS..."
    ln -s /home/$MYUSER/waydroid-gapps /home/$MYUSER/.local/share/waydroid
  fi
  if [ -d "/home/$MYUSER/.local/share/waydroid" ]; then
    echo "$FLAVOUR => User data linked."
  else 
    echo "$FLAVOUR => Linking user data failed. Try again."
    exit 1
  fi
  echo ""

  echo "$FLAVOUR => Linking system.img"
  if [[ $1 = "vanilla" ]]; then
    echo "$FLAVOUR => Linking VANILLA..."
    sudo ln -s $WDHOME/images/system.img-vanilla $WDHOME/images/system.img
  else
    echo "$FLAVOUR => Linking GAPPS..."
    sudo ln -s $WDHOME/images/system.img-gapps $WDHOME/images/system.img
  fi
  if [ -f "$WDHOME/images/system.img" ]; then
    echo "$FLAVOUR => system.img linked."
  else 
    echo "$FLAVOUR => Linking system.img failed. Try again."
    exit 1
  fi
  echo ""

#========== ADJUST DESKTOP ICON =========================
  sed -i -e '/AppIcon/d' $DESKTOPICON
  echo "AppIcon removed"
  if [[ $1 = "vanilla" ]]; then
    echo "$VANILLAICON" >> $DESKTOPICON
  else
    echo "$GAPPSICON" >> $DESKTOPICON
  fi
  echo "$FLAVOUR icon has distributed into desktop file"
  echo ""
  
#========== START WAYDROID =========================
  echo "$FLAVOUR => Starting Waydroid Container..."
  sudo systemctl start waydroid-container
  echo "$FLAVOUR => Waydroid Container started."
  echo ""

  echo "$FLAVOUR => Starting Waydroid Session..."
  systemctl --user start waydroid-session
  echo "$FLAVOUR => Waydroid Session started"
  echo "$FLAVOUR => Now, you can start the UI. Enjoy! ;-)"
  echo ""

else
  echo "USAGE: waydroid-start.sh vanilla|gapps"
  exit 1
fi
