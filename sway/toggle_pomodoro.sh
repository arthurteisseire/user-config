#!/usr/bin/env bash

script_name="toggle_pomodoro"


sentences[0]="Start with one line"
sentences[1]="Today is a gift"
sentences[2]="3 Breathes"
sentences[3]="Attitude"
sentences[4]="Fais de ton mieux"
sentences[5]="Renforcement de la nuque"
sentences[6]="I am a warrior"
sentences[7]="Pose ta question"


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
    ~/.config/sway/swayexit lock
  done
fi
