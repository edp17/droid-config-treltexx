#!/bin/bash

/usr/sbin/brcm_patchram_plus --enable_hci --enable_lpm --no2bytes --tosleep 50000 --baudrate 921600 --use_baudrate_for_download --patchram /system/vendor/firmware/BCM4358A1_V0054.0094.hcd --bd_addr `cat /efs/bluetooth/bt_addr` --scopcm=0,0,0,0,0,0,0,3,3,0 /dev/ttySAC3
