%package -n patterns-sailfish-device-configuration-treltexx
Summary: Jolla Configuration treltexx
Requires: patterns-sailfish-device-configuration-common-treltexx
Requires: patterns-sailfish-device-adaptation-treltexx

# For devices with cellular modem. Those without one, please comment out:
Requires: patterns-sailfish-cellular-apps
# Early stages of porting benefit from these:
#Requires: sailfish-porter-tools
Requires: patterns-sailfish-rnd
# dev-tools pattern will be fixed in the next release
# for now we'll use its 'exploded' version:
#Requires: patterns-sailfish-dev-tools
Recommends: jolla-developer-mode
Requires: strace
Requires: gdb
Requires: gdb-gdbserver
Requires: vim-enhanced
Requires: less
Requires: valgrind
Requires: lipstick-qt5-tools
Requires: libhybris-tests
Requires: busybox-static
Requires: openssh-server
Requires: zypper
Requires: gnu-bash
Requires: psmisc-tools


Requires: sailfish-content-graphics-z%{icon_res}

# For multi-SIM devices
#Requires: jolla-settings-networking-multisim

# Introduced starting Sailfish OS 2.0.4.x:
# 3rd party accounts like Twitter, VK, cloud services, etc
Requires: jolla-settings-accounts-extensions-3rd-party-all

# Introduced starting Sailfish OS 2.1.1.26
# Required for Jolla Store Access
Requires: patterns-sailfish-consumer-generic

# For Mozilla location services (online)
Requires: geoclue-provider-mlsdb

# Sailfish OS CSD tool for hardware testing
# needs some configuration to get all features working

# Devices with 2G or more memory should also include this booster
# to improve camera startup times and the like
Requires: mapplauncherd-booster-silica-qt5-media

# install flashlight
Requires: jolla-settings-system-flashlight

# install some packages
Requires: mce-tools
Requires: connman-tools
Requires: yamuisplash

%description -n patterns-sailfish-device-configuration-treltexx
Pattern with packages for treltexx configurations

%files -n patterns-sailfish-device-configuration-treltexx
