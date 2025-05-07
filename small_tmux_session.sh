
#!/bin/bash

# Check if an argument was provided
if [ $# -eq 0 ]; then
  echo "Usage: $0 <session_name>"
  echo "Example: $0 earthen_heart"
  exit 1
fi

# Name of the tmux session from first argument
SESSION_NAME="$1"

# Check if the session already exists
tmux has-session -t $SESSION_NAME 2>/dev/null

# If the session doesn't exist, create it
if [ $? != 0 ]; then
  # Create a new session with the first window named "term"
  tmux new-session -s $SESSION_NAME -n term -d
  
  # change to home dir in new pane
  tmux send-keys -t $SESSION_NAME:term "cd $HOME" C-m
  
  # Create a second window named "other"
  tmux new-window -t $SESSION_NAME -n other
  
  # Change to the home directory in the other window
  tmux send-keys -t $SESSION_NAME:other "cd $HOME" C-m
  
  # Select the first window
  tmux select-window -t $SESSION_NAME:term
fi

# Attach to the session
tmux attach-session -t $SESSION_NAME
