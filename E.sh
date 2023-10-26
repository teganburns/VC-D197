#!/bin/bash
#E.sh

source setup.sh

#Simulate A Merge Conflict
#E.  Introduce a merge conflict with the “README " branch by doing the following:
#•  add the git version to the README .md file on the master branch
#•  merge the “README” branch to the master branch
#•  include a screenshot that demonstrates the conflict of this merge command line action and be sure to have your repository name visible in the command prompt
#1.  Resolve the created conflict and push changes to the master branch in GitLab. Include a screenshot of the current repository graph in GitLab.


clear_tmp_files "E"
clear_tmp_files "E1"


# Give mux a second
sleep 1

# Wait for script B to finish
script_rainbow "D"

# Move into the repository directory or exit
execute_command "cd ${REPO_NAME} || exit 1"

# Make things look pretty for the screenshot
clear

execute_command "git rev-parse --show-toplevel"

# Switch to the main (not master) branch (or create it if it doesn't exist)
execute_command "git checkout main"

# Add the Git version to the README.md file at the top
git --version | head -n 1 | cat - README.md > temp && mv temp README.md


fake_execute_command "vim README.md"

# Commit the changes
execute_command "git add *"
execute_command "git commit -m \"Add Git version to README.md on master branch\""


# Merge the README branch into the master branch
execute_command "git merge README"

fake_execute_command ""

# Screenshot for terminal
screenshot_ready "E"

timeout_duration=60  # Timeout duration in seconds
start_time=$(date +%s)  # Get the current timestamp

while true; do
    current_time=$(date +%s)
    elapsed_time=$((current_time - start_time))

    if [ "$elapsed_time" -ge "$timeout_duration" ]; then
        echo "Timeout: 60 seconds passed. Exiting loop."
        break
    fi

    if check_image_file "E"; then
        clear
        ask_yes_no "Now refresh the graph and take a screenshot. Type \"y\" when ready."
        break
    fi

    sleep 1  # Sleep for 1 second before checking again
  done

clear;

# Resolve merge conflict
execute_command "tail -n +6 README.md > temp && mv temp README.md"

# Commit the changes
execute_command "git add *"
execute_command "git commit -m \"Fixed merge conflict\""
execute_command "git merge README"
execute_command "git push"

screenshot_ready "E1"

