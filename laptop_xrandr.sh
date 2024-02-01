#!/bin/bash
xrandr --output eDP-1-1 --auto --output HDMI-1-1 --off
echo "Xft.dpi: 150" | exec xrdb
i3 restart
