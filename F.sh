#!/bin/bash
#F.sh

source setup.sh

#Tag A Branch
#F.  Specify a version for your repository by doing the following:
#•  tag the master branch V.1.0.0
#•  push the tag to GitLab
#•  include a screenshot of the command line action and be sure to have your repository name visible in the command prompt
#1.  Include a screenshot of the current repository graph in GitLab.


clear_tmp_files "F"
clear_tmp_files "F1"


# Give mux a second
sleep 1

# Wait for script E to finish
script_rainbow "E"

# Move into the repository directory or exit
execute_command "cd ${REPO_NAME} || exit 1"

clear

# Check if we are in ${REPO_NAME}
if [ "$(basename "$(pwd)")" != "$REPO_NAME" ]; then
  # Check if the directory exists
  if [ -d "$REPO_NAME" ]; then
    # Move into the repository directory or exit
    execute_command "cd ${REPO_NAME} || exit 1"
  else
    echo "Directory '$REPO_NAME' does not exist."
    exit 1
  fi
fi



# Teg master branch V.1.0.0
execute_command "git tag -a V.1.0.0 -m \"Version Tag for F\" && git push origin V.1.0.0"

# Screenshot command line
screenshot_ready "F"

# Screenshot repo graph
timeout_duration=60  # Timeout duration in seconds
start_time=$(date +%s)  # Get the current timestamp

while true; do
    current_time=$(date +%s)
    elapsed_time=$((current_time - start_time))

    if [ "$elapsed_time" -ge "$timeout_duration" ]; then
        echo "Timeout: 60 seconds passed. Exiting loop."
        break
    fi

    if check_image_file "F"; then
        clear
        ask_yes_no "Now refresh the graph and take a screenshot. Type \"y\" when ready."
        screenshot_ready "F1"
        break
    fi

    sleep 1  # Sleep for 1 second before checking again
  done



