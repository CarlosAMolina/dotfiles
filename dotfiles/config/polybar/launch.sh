#!/usr/bin/env bash

# https://atareao.es/tutorial/polybar/primeros-pasos-con-tu-propia-barra-de-estado/

# Si quieres depurar cambia a DEBUG=1
DEBUG=0

# Termina todas las instacias de polybar
killall -q polybar
# Si las barras tienen `ipc` habilitado lo puedes utilizar con
# polybar-msg cmd quit

# Inicia las barras de estado `bar1`
if [ $DEBUG -eq 1 ]
then
    echo "---" | tee -a /tmp/polybar1.log /tmp/polybar2.log
    polybar bar1 2>&1 | tee -a /tmp/polybar1.log & disown
else
    polybar bar1 >/dev/null 2>&1 & disown
fi
echo "Tool bars initialized"
