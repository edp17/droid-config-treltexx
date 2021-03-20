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

if [[ $1 == "off" ]]; then
  echo 'idle' > /wifi-prev-status
  sleep 1
  exit 0
elif [[ $1 == "on" ]]; then
  echo 'online' > /wifi-prev-status
  sleep 1
  exit 0
else
  exit 1
fi
