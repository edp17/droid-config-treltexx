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

CMD_RUNUSER="sudo /sbin/runuser -l $MYUSER -c "
SPEN_APP="harbour-spen-menu"
SPEN_APP_PATH="/usr/bin/$SPEN_APP"

spenAppControl()
{
    #checking whether the paint app is running
    if ps ax | grep -v grep | grep $SPEN_APP > /dev/null
    then
    #if running
	#if parameter is 'S'tart
	if [ $1 == "E" ]
	then
	    #end it
	    killall $SPEN_APP
	fi
    else
    #if not running
	#if parameter is 'S'tart
	if [ $1 == "S" ]
	then
	    #start it
	    $CMD_RUNUSER $SPEN_APP_PATH &
	fi
    fi
}

EVENT_OUT='*type 5 (EV_SW), code 19 (?), value 1*'
EVENT_BACK='*type 5 (EV_SW), code 19 (?), value 0*'

$CMD_RUNUSER "/usr/bin/droid/evtest /dev/input/event3" | while read line; do
  case $line in
    ($EVENT_OUT)
    #S-Pen is out
    spenAppControl S
    ;;
    ($EVENT_BACK)
    #S-Pen is back
    spenAppControl E
    ;;
  esac
done
