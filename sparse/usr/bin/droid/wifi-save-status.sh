#!/bin/bash

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
