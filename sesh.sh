#!/bin/bash

if [[ $# -eq 1 ]]; then
  DIR=$1

else
  folders=$(find ~/projects/ -type d)

  DIR=$(echo "$folders" | sed 's/^\(.*projects\/\)/projects\//' | fzf)
fi

SESH=$(basename "$DIR")

tmux has-session -t $SESH 2>/dev/null

if [ $? != 0 ]; then
  tmux new-session -d -s $SESH -n "editor"

  tmux send-keys -t $SESH:editor "cd $DIR" C-m
  tmux send-keys -t $SESH:editor "nvim ." C-m

  tmux new-window -t $SESH -n "term"
  tmux send-keys -t $SESH:term "cd $DIR" C-m
  tmux send-keys -t $SESH:term "clear" C-m

  tmux select-window -t $SESH:editor
fi

if [[ -n "$TMUX" ]]; then

else
  tmux attach-session -t $SESH
fi
