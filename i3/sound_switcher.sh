#!/bin/bash
active_snd_crd=$(pactl list short sinks | grep RUNNING | awk '{print $1}')
if [ $active_snd_crd == 1 ]
then
	exec pacmd set-default-sink 16
else
	exec pacmd set-default-sink 1
fi
