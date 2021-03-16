#!/usr/bin/env bash

DUNST=`pidof dunst`

WINDOWS=`swaymsg -t get_tree | jq '.. | (.nodes? // empty)[] | select(.visible and .pid) | .rect | "\(.x),\(.y) \(.width)x\(.height)"'`
FOCUSED=`swaymsg -t get_tree | jq '.. | (.nodes? // empty)[] | select(.focused and .pid) | .rect | "\(.x),\(.y) \(.width)x\(.height)"'`


FILENAME="/home/arthur/pictures/screenshots/$(date +'%Y-%m-%d-%H%M%S_screenshot.png')"

grim -g "$(eval echo $FOCUSED)" "$FILENAME"

wl-copy < $FILENAME
feh $FILENAME
if [ $DUNST ]; then
    notify-send "Screenshot" "File saved as $FILENAME\nand copied to clipboard" -t 6000 -i $FILENAME
fi
