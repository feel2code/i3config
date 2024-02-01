#!/bin/bash
xrandr --output eDP1 --auto --pos 0x509 --output DP1 --auto --scale 2x2 --pos 2240x0
echo "Xft.dpi: 200" | exec xrdb
i3 restart
