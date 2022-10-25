#!/bin/sh

layout=$(xkblayout-state print %s)
setxkbmap us
i3lock-fancy-dualmonitor -p
if [ "am" = "$1" ]; then
    setxkbmap -variant phonetic-alt
elif [ "ru" = "$1" ]; then
    setxkbmap -variant phonetic
fi
pgrep i3status | xargs --no-run-if-empty kill -s USR1 # tell i3status to update
