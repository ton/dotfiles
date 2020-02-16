#!/bin/sh

MONITORS=()
MONITORS+=("DP-2-2")
MONITORS+=("DP-2")
MONITORS+=("HDMI-1")
MONITORS+=("DP2-2")
MONITORS+=("DP2")
MONITORS+=("HDMI1")

LAPTOP_DISPLAYS=()
LAPTOP_DISPLAYS+=("eDP-1")
LAPTOP_DISPLAYS+=("eDP1")

# Determine connected laptop display.
for laptop_display in ${LAPTOP_DISPLAYS[@]}; do
    STATUS=`xrandr -d ${DISPLAY} -q | grep ${laptop_display} | awk '{print $2}'`
    if [ "${STATUS}" = "connected" ]; then
        LAPTOP_DISPLAY=$laptop_display
        break
    fi
done

for monitor in ${MONITORS[@]}; do
    STATUS=`xrandr -d ${DISPLAY} -q | grep ${monitor} | awk '{print $2}'`
    echo $STATUS

    if [ "${STATUS}" = "connected" ]; then
        xrandr -d ${DISPLAY} --output ${monitor} --auto --output ${LAPTOP_DISPLAY} --off

        # Rescale background image.
        sh $HOME/.fehbg &

        # Export monitor environment variable (used by polybar).
        export MONITOR=${monitor}

        logger "Monitor connected, using monitor as primary output."

        break
    fi
done

if [ -z $MONITOR ]
then
    logger "Monitor not connected, using laptop display as primary output."

    # Export monitor environment variable (used by polybar).
    export MONITOR=${LAPTOP_DISPLAY}
fi

# Rescale background image.
sh $HOME/.fehbg &
