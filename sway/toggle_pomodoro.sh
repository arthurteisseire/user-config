#!/usr/bin/env bash

script_name="toggle_pomodoro"


sentences[0]="Be enthusiast !!!"
sentences[1]="Pleine présence !"
sentences[2]="Today is a gift"
sentences[3]="3 Breathes"
sentences[4]="Slow down"
sentences[5]="Set your goal"


killpy() {
    ps auxw | grep [p]omodoro | awk '{print $2}' | grep -v $1 | xargs kill -9
}

if [ $(ps -ef | grep -v grep | grep $script_name | wc -l) -gt 2 ]; then
  notify-send -t 4000 --icon=gtk-info Pomodoro "Pomodoro is now stopped"
  killpy $$
else
  while true
    size=${#sentences[@]}
    index=$(($RANDOM % $size))
    chosen_sentence=${sentences[$index]}
    notify-send -t 4000 --icon=gtk-info Pomodoro "$chosen_sentence"
    do sleep 1500
    swaylock
  done
fi
