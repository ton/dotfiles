#!/bin/sh

# Determine connected laptop display.
laptop_display=$(xrandr --listactivemonitors | grep ": +\*" | sed 's/.*\*\(\S*\).*/\1/')

echo "Laptop display: $laptop_display"

# Determine the connected monitor.
xrandr --listactivemonitors | while read -r line; do
    if echo "$line" | grep -qe ": +[^*]"; then
        monitor=$(echo "$line" | sed 's/[^+]*+\(\S*\).*$/\1/')
        xrandr -d ${DISPLAY} --output ${monitor} --auto --output ${laptop_display} --off
        logger "Monitor connected, using monitor as primary output."

        # Rescale background image.
        sh $HOME/.fehbg &

        exit 0
    fi
done

exit 1
