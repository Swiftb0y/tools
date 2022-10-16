#/usr/bin/env sh

echo $1 > /sys/class/power_supply/BAT0/charge_stop_threshold
