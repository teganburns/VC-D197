#!/bin/bash


TMUX_SESSION="WGU_VC_D197"

# Create a new Tmux session named "TMUX_SESSION"
tmux new-session -d -s $TMUX_SESSION

# Split the current pane vertically and horizontally
tmux split-window -v -t 0
tmux split-window -h -t 0
tmux split-window -h -t 2




# Define an array of script names
scripts=("A.sh" "B.sh" "C.sh" "D.sh" "E.sh", "F.sh", "G.sh")

# Initialize a counter for the tmux window index
window_index=0

# Loop through the scripts and execute them sequentially
for script in "${scripts[@]}"; do
    # Execute the script in the corresponding tmux window and create a completion file
    tmux send-keys -t $window_index "./$script" C-m



    # Increment the window index for the next script
    ((window_index++))
done


# Optionally, you can create more panes and execute additional scripts




# Define an array to map letters to pane numbers
pane_mapping=("a" "b" "c" "d" "e" "f" "g")

# Function to get the pane number corresponding to a letter
get_pane_number() {
  letter="$1"
  for i in "${!pane_mapping[@]}"; do
    if [ "${pane_mapping[$i]}" = "$letter" ]; then
      echo "$i"
      return
    fi
  done
  exit 1
}
# Function to run the loop for 15 minutes
suicide_in_5_minutes() {
  # Get the current time in seconds
  start_time=$(date +%s)

  # Run the loop for 15 minutes (900 seconds)
  while [ $(( $(date +%s) - start_time )) -lt 240 ]; do
    for letter in {a..g}; do
      file="/tmp/script.kill.pane.$letter"
      if [ -e "$file" ]; then
        pane_number=$(get_pane_number "$letter")
        tmux kill-pane -t "$pane_number"
        echo "Killed pane $pane_number corresponding to $letter"
        rm "$file"
      fi
    done
    sleep 5
  done

  tmux kill-session -t $TMUX_SESSION 
}

suicide_in_5_minutes &

# Attach to the Tmux session
tmux attach-session -t $TMUX_SESSION 

