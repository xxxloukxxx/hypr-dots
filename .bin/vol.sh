#!/bin/bash

volume_step=5
max_volume=100

function get_volume {
    pactl get-sink-volume @DEFAULT_SINK@ | grep -Po '[0-9]{1,3}(?=%)' | head -1
}

function get_mute {
    pactl get-sink-mute @DEFAULT_SINK@ | grep -Po '(?<=Mute: )(yes|no)'
}


case $1 in
    up)
    pactl set-sink-mute @DEFAULT_SINK@ 0
    volume=$(get_volume)
    if [ $(( "$volume" + "$volume_step" )) -gt $max_volume ]; then
        pactl set-sink-volume @DEFAULT_SINK@ $max_volume%
    else
        pactl set-sink-volume @DEFAULT_SINK@ +$volume_step%
    fi
    ;;

    dn)
    pactl set-sink-volume @DEFAULT_SINK@ -$volume_step%
    ;;

    mute)
    pactl set-sink-mute @DEFAULT_SINK@ toggle
    ;;

    *)
    volume=$(get_volume)
    mute=$(get_mute)
    if [ "$mute" = "no" ]; then
        echo "Vol.:$volume%"
    else
        echo "Mute"
    fi
esac

pid=$(pidof dwmblocks)

[ -z "$pid" ] || kill -39 $pid

