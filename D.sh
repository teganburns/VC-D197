#!/bin/bash
#C.sh

source setup.sh

#D.  Modify a file on a new branch doing the following:
#•  create a “README” branch using the command line interface
#•  add your student ID to the README.md file
#•  push the changes to the remote repository
#•  include a screenshot of the command line action and be sure to have your repository name visible in the command prompt
#1.  Include a screenshot of the current repository graph in GitLab after pushing changes.



clear_tmp_files "D"
clear_tmp_files "D1"

# Give mux a second
sleep 1

# Wait for script B to finish
script_rainbow "C"

# Move into the repository directory or exit
execute_command "cd ${REPO_NAME} || exit 1"


# Make things look pretty for the screenshot
clear
execute_command "git checkout -b README"
fake_execute_command "vim README.md"

# add your student ID to the README.md file
echo "$STUDENT_ID" | cat - README.md > temp && mv temp README.md && rm temp

execute_command "git rev-parse --show-toplevel"
execute_command "git add *"
execute_command "git commit -m \"Add student id to README.md on README branch\""
execute_command "git push --set-upstream origin README"
execute_command "git push"
execute_command "git rev-parse --show-toplevel"
fake_execute_command ""

# Screenshot for terminal
screenshot_ready "D"

timeout_duration=60  # Timeout duration in seconds
start_time=$(date +%s)  # Get the current timestamp

while true; do
    current_time=$(date +%s)
    elapsed_time=$((current_time - start_time))

    if [ "$elapsed_time" -ge "$timeout_duration" ]; then
        echo "Timeout: 60 seconds passed. Exiting loop."
        break
    fi

    if check_image_file "D"; then
        clear
        ask_yes_no "Now refresh the graph and take a screenshot. Type \"y\" when ready."
        screenshot_ready "D1"
        break
    fi

    sleep 1  # Sleep for 1 second before checking again
  done

script_complete "D"
