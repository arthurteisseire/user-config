#!/usr/bin/env bash

script_name="toggle_pomodoro"


sentences[0]="Pleine présence !"
sentences[1]="Today is a gift"
sentences[2]="3 Breathes"
sentences[3]="Slow down"
sentences[4]="Définis simplement ton objectif"
sentences[5]="Fais de ton mieux"
sentences[6]="J'aime la vie"
sentences[7]="J'aime ce que j'entreprends"
sentences[8]="I am a warrior"


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
