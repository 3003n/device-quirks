#!/bin/bash
# This file runs during sleep/resume events. It will read the list of modules
# in /etc/device-quirks/systemd-suspend-mods.conf and modprobe -r them on suspend,
# modprobe them on resume.

MOD_LIST=$(grep -v ^\# /etc/device-quirks/systemd-suspend-mods.conf)

case $1 in
    pre)
        for mod in $MOD_LIST; do
            modprobe -r $mod
        done
    ;;
    post)
        for mod in $MOD_LIST; do
            modprobe $mod
        done
    ;;
esac
