#! /bin/bash

function set_temp() {
  busctl --user -- set-property rs.wl-gammarelay / rs.wl.gammarelay Temperature q $1
}

TEMP=`busctl --user get-property rs.wl-gammarelay / rs.wl.gammarelay Temperature | awk '{print $2}'`

if [[ $TEMP -eq 6500 ]]
then
  set_temp 3000
else
  set_temp 6500
fi
