#!/bin/bash
xrandr --output HDMI-1 --auto --scale 2x2 --pos 0x0 --output eDP-1 --auto --pos 3840x760
echo "Xft.dpi: 200" | exec xrdb
i3 restart
