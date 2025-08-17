#!/usr/bin/env bash

get_icon() {
    case "$1" in
        spotify)    echo "" ;;
        firefox)    echo "" ;;
        chromium)   echo "" ;;
        mpv)        echo "󰐹" ;;
        vlc)        echo "󰕼" ;;
        mopidy)     echo "" ;;
        kdeconnect) echo "" ;;
        *)          echo "" ;; # default
    esac
}

# Stream playerctl events in real time
playerctl metadata --follow --format '{{playerName}}:{{status}}:{{artist}} - {{title}}' 2>/dev/null | while IFS=: read -r player status track; do
    icon=$(get_icon "$player")
    
    case "$status" in
        Playing)  status_icon="" ;;   # play
        Paused)   status_icon="󰐎" ;;  # pause
        Stopped)  status_icon="" ;;  # stop
        *)        status_icon=""   ;;
    esac
    
    if [[ -z "$track" ]]; then
        echo "{\"text\": \"  No music playing\", \"tooltip\": \"No active player\"}"
    else
        echo "{\"text\": \"$icon $status_icon $track\", \"tooltip\": \"$player: $track\"}"
    fi
done
