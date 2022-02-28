#!/usr/bin/env bash

# https://atareao.es/tutorial/polybar/primeros-pasos-con-tu-propia-barra-de-estado/

# Debug: set DEBUG=1
DEBUG=0

# Kill all polybar instances
killall -q polybar
# If the bars have `ipc` enabled, it can be used with
# polybar-msg cmd quit

# Network interfaces
export INTERFACE_ETHERNET="$(ls /sys/class/net | grep enp)"
export INTERFACE_WIRELESS="$(ls /sys/class/net | grep wlp)"

# Start bar
if [ $DEBUG -eq 1 ]
then
    echo "---" | tee -a /tmp/polybar1.log
    polybar bar1 2>&1 | tee -a /tmp/polybar1.log & disown
else
    polybar bar1 >/dev/null 2>&1 & disown
fi
echo "Tool bars initialized"
