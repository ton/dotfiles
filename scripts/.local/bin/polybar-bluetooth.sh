#!/bin/sh
bluetooth_icon=$(printf '\Uf00af') # mdi-bluetooth (0xf00af)
if [ $(bluetoothctl show | grep "Powered: yes" | wc -c) -eq 0 ]
then
  echo "%{F#66ffffff}$bluetooth_icon"
else
  if [ $(echo info | bluetoothctl | grep 'Device' | wc -c) -eq 0 ]
  then
    echo "$bluetooth_icon"
  fi
  echo "%{F#2193ff}$bluetooth_icon"
fi
