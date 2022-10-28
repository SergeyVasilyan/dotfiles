#!/bin/sh

layout=$(xkblayout-state print %s)
setxkbmap us
i3lock-fancy-dualmonitor -p
setxkbmap $layout
if [ "am" = "$layout" ]; then
    setxkbmap -variant phonetic-alt
elif [ "ru" = "$layout" ]; then
    setxkbmap -variant phonetic
fi
pgrep i3status | xargs --no-run-if-empty kill -s USR1 # tell i3status to update
