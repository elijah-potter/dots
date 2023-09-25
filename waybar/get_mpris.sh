#!/bin/bash

# This script exists only because the native waybar support for MPRIS can cause it to crash.

if [ "$(playerctl metadata title)" != "" ]
then
  echo $(playerctl metadata title) 'by' $(playerctl metadata artist)
fi
