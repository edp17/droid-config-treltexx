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

if [[ $1 != "" ]]; then
  echo "Step 1."
  echo "Checking the container $1..."
  if ps ax | grep -v grep | grep lxc-start > /dev/null
  then
      echo "The container $1 is running..."
  else
      echo "The container $1 is not running..."
      echo "Starting the container $1..."
      sudo lxc-start -n $1 -d
      sleep 1
      ps ax | grep -v grep | grep lxc-start
      echo "Step 1. Done"
  fi
  echo "Step 2."
  echo "Starting qxdisplay as defaultuser..."
  `/usr/bin/qxcompositor --wayland-socket-name "../../display/wayland-container-0"` &
  sleep 2
  echo "Attach the container $1 as root..."
  sudo lxc-attach -n $1 -- /mnt/guest/start_desktop.sh 0 &
  echo "Step 2. Done"
  exit 0
else
  echo "USAGE: $0 <container-name>"
  exit 1
fi
