#!/bin/zsh

for _pane in $(tmux list-panes -a -F '#{pane_id}'); do
    if [[ $(tmux display-message -t $_pane -p -F '#{pane_current_command}') = "nvim" ]]; then
        tmux send-keys -t $_pane Escape ':call SetBackground()' Enter
    fi
done
