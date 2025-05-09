
#!/bin/bash

# Name of the tmux session
SESSION_NAME="earthen_heart"

# Check if the session already exists
tmux has-session -t $SESSION_NAME 2>/dev/null

# If the session doesn't exist, create it
if [ $? != 0 ]; then
  # Create a new session with the first window named "code"
  tmux new-session -s $SESSION_NAME -n code -d
  
  # Change to the earthen_heart directory in the first pane
  tmux send-keys -t $SESSION_NAME:code "cd $ehdir" C-m
  
  # Open nvim in the pane
  tmux send-keys -t $SESSION_NAME:code "vim" C-m

  # Create a second window named "term"
  tmux new-window -t $SESSION_NAME -n term
  
  # Change to the earthen_heart directory in the term window
  tmux send-keys -t $SESSION_NAME:term "cd $ehdir" C-m
  
  # Create a third window named "other"
  tmux new-window -t $SESSION_NAME -n other
  
  # Stay at root directory for the "other" window
  tmux send-keys -t $SESSION_NAME:other "cd $home" C-m
  
  # Select the first window
  tmux select-window -t $SESSION_NAME:code
fi

# Attach to the session
tmux attach-session -t $SESSION_NAME
