#! /bin/bash

function set_temp() {
  busctl --user -- set-property rs.wl-gammarelay / rs.wl.gammarelay Temperature q $1
}

function set_brightness() {
  busctl --user -- set-property rs.wl-gammarelay / rs.wl.gammarelay Brightness d $1
}

TEMP=`busctl --user get-property rs.wl-gammarelay / rs.wl.gammarelay Temperature | awk '{print $2}'`

if [[ $TEMP -eq 6500 ]]
then
  set_temp 3000
  set_brightness 0.8
else
  set_temp 6500
  set_brightness 1
fi
