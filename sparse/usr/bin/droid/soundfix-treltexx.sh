#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi


echo 'Remounting /system for read and write...'
mount -o remount,rw /system
echo '/System remounted'

echo 'Archiving /system/etc/audio_policy.conf'
mv /system/etc/audio_policy.conf /system/etc/audio_policy.conf-archive

echo 'Copying /etc/pulse/custom_audio_policy.conf'
cp /etc/pulse/custom_audio_policy.conf /system/etc/audio_policy.conf

echo 'Restart pulseaudio service'
systemctl-user restart pulseaudio.service

echo 'Soundfix has applied.'
echo 'Test it with playing some sound in Settings/Sounds and feedback.'

