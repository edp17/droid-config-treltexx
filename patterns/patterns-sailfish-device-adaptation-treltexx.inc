%package -n patterns-sailfish-device-adaptation-treltexx
Summary: Jolla HW Adaptation treltexx
Requires: droid-hal-treltexx
Requires: droid-hal-treltexx-img-boot
Requires: droid-hal-treltexx-kernel-modules
Requires: droid-config-treltexx-sailfish
Requires: droid-config-treltexx-pulseaudio-settings
Requires: droid-config-treltexx-policy-settings
Requires: droid-config-treltexx-preinit-plugin
Requires: droid-config-treltexx-flashing
Requires: droid-config-treltexx-bluez5
Requires: droid-hal-version-treltexx

# Hybris packages
Requires: libhybris-libEGL
Requires: libhybris-libGLESv2
Requires: libhybris-libwayland-egl

# Sensors
Requires: hybris-libsensorfw-qt5

# Vibra
Requires: ngfd-plugin-native-vibrator
Requires: qt5-feedback-haptics-native-vibrator

# Needed for /dev/touchscreen symlink
Requires: qt5-plugin-generic-evdev

Requires: pulseaudio-modules-droid
Requires: pulseaudio-modules-droid-hidl

# The -dummy-af is needed for newer devices that run the main
# audiosystem-passthrough in qti mode (e.g. >=Android 9 Qualcomm),
# to fix non-responding Camera app and/or voice during a phone call:
#Requires: audiosystem-passthrough-dummy-af

# for audio recording to work:
Requires: qt5-qtmultimedia-plugin-mediaservice-gstmediacapture

# These need to be per-device due to differing backends (fbdev, eglfs, hwc, ..?)
Requires: qt5-qtwayland-wayland_egl
Requires: qt5-qpa-hwcomposer-plugin
Requires: qtscenegraph-adaptation

# Add GStreamer v1.0 as standard
Requires: gstreamer1.0
Requires: gstreamer1.0-plugins-good
Requires: gstreamer1.0-plugins-base
Requires: gstreamer1.0-plugins-bad
Requires: nemo-gstreamer1.0-interfaces
# For devices with droidmedia and gst-droid built, see HADK pdf for more information
Requires: gstreamer1.0-droid

# This is needed for notification LEDs
Requires: mce-plugin-libhybris

# USB mode controller
Requires: usb-moded

# hammerhead, grouper, and maguro use this in scripts, so include for all
Requires: rfkill

# enable device lock and allow to select untrusted software
Requires: jolla-devicelock-daemon-encsfa

# Enable home encryption
#Requires: sailfish-device-encryption

# For GPS
Requires: geoclue-provider-hybris

# For Bluetooth
Requires: bluetooth-rfkill-event-hciattach
Requires: broadcom-bluetooth-bluez5

# For FM radio on some QCOM devices
#Requires: qt5-qtmultimedia-plugin-mediaservice-irisradio
#Requires: jolla-mediaplayer-radio

# NFC for devices using Android 8 or newer as base
#Requires: nfcd-binder-plugin
#Requires: jolla-settings-system-nfc

%description -n patterns-sailfish-device-adaptation-treltexx
Pattern with packages for treltexx HW Adaptation

%files -n patterns-sailfish-device-adaptation-treltexx
