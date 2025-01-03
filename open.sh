#!/bin/bash

# Get a list of all tmux sessions.
sessions=$(tmux list-sessions | cut -d: -f1)

# Filter the list of sessions using fzf.
selected_session=$(echo "$sessions" | fzf)

# If a session was selected, switch to it.
if [ -n "$selected_session" ]; then
  tmux switch-client -t "$selected_session"
fi
