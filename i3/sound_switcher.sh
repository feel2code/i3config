#!/bin/bash
active_snd_crd=$(pactl list short sinks | grep RUNNING | awk '{print $1}')
inactive_snd_crd=$(pactl list short sinks | grep SUSPENDED | awk '{print $1}')
if [ $active_snd_crd == 1 ]
then
	exec pacmd set-default-sink $inactive_snd_crd
else
	exec pacmd set-default-sink 1
fi
