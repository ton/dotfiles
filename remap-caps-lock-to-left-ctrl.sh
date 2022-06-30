#!/bin/sh
echo -e "evdev:atkbd:dmi:*\n  KEYBOARD_KEY_3a=leftctrl" > /etc/udev/hwdb.d/10-keyboard.hwdb

systemd-hwdb update
udevadm trigger
