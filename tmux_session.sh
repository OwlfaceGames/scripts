
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
  # Create a new session with the first window named "code"
  tmux new-session -s $SESSION_NAME -n code -d
  
  # Change to the project directory in the first pane
  # Using the session name as the directory name
  tmux send-keys -t $SESSION_NAME:code "cd $HOME" C-m
  
  # Split the window vertically
  tmux split-window -h -t $SESSION_NAME:code
  
  # Change to the project directory in the right pane
  tmux send-keys -t $SESSION_NAME:code.2 "cd $HOME" C-m
  
  # Open vim in the second pane
  tmux send-keys -t $SESSION_NAME:code.2 "vim" C-m

  # Create a second window named "term"
  tmux new-window -t $SESSION_NAME -n term
  
  # Change to the project directory in the term window
  tmux send-keys -t $SESSION_NAME:term "cd $HOME" C-m
  
  # Create a third window named "other"
  tmux new-window -t $SESSION_NAME -n other
  
  # Stay at home directory for the "other" window
  tmux send-keys -t $SESSION_NAME:other "cd $HOME" C-m
  
  # Select the first window
  tmux select-window -t $SESSION_NAME:code
fi

# Attach to the session
tmux attach-session -t $SESSION_NAME
