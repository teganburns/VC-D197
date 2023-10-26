#!/bin/bash
#A.sh

source setup.sh

#Prepare Your Repository With Initial Data On GitLab
#A.  Create a private repository in gitlab.com named “(yourstudentID) D197” that includes all the files contained in the attached "WGU-Hub.zip."
#1.  Include the repository link in the ”Comments to Evaluator” section when you submit your task.
#2.  Add “WGU-Evaluation” as a member with reporter access to your repository on GitLab.
#3.  Include a screenshot of your current repository graph in GitLab.


# Check if the STUDENT_PROJECT_REPO_URL environment variable is set
if [ -z "$STUDENT_PROJECT_REPO_URL" ]; then
    echo "Error: STUDENT_PROJECT_REPO_URL environment variable is not set."
    exit 1
fi

# Check if the STUDENT_ID environment variable is set
if [ -z "$STUDENT_ID" ]; then
    echo "Error: STUDENT_ID environment variable is not set."
    exit 1
fi

#give mux a second
sleep 1

clear_tmp_files "A"
clear_tmp_files "A3"

echo -e "\033[1m\033[4m\033[32mRepository Submission Checklist:\033[0m\n\033[1m1) Include the Repository Link:\033[0m Have you included the repository link in the 'Comments to Evaluator' section when you submit your task? If not, \033[31mplease include the link for the evaluator.\033[0m\n\033[1m2) Add WGU-Evaluation to GitLab Repo:\033[0m Did you add 'WGU-Evaluation' as a member with reporter access to your repository on GitLab? If not, \033[31madd 'WGU-Evaluation' as a reporter to your repository.\033[0m\n\033[1m3) Repo Privacy:\033[0m Is your repository private? If not, \033[31myou will need to make your repository private.\033[0m\n\033[1m4) Screenshot of Repository Graph:\033[0m You will be need to take a screenshot of your repository graph on Gitlab.\n \033[31m Waiting for screenshot...\033[0m"


# If image file already exists remove it
#remove_image_file "A3"
screenshot_ready "A3"
screenshot_rainbow "A3"

# Poll every 5 seconds to check for an image file
# Image must exist for all of A to be completed
count=0
while [[ $count -lt 60 ]]; do
    
    # Check image file within the if condition
    if check_image_file "A3"; then
        touch "/tmp/script.A.complete"
        echo "Image file found, completion file created."
        break
    fi
    
    # Increment the counter
    count=$((count + 1))

    # Check if count has reached 60 and exit with message if it has
    if [[ $count -eq 60 ]]; then
        echo "Timeout, image file not found."
        exit 1
    fi

    sleep 1
done



# B
sleep 1
clear
screenshot_rainbow "B"
script_complete "B"
tmux send-keys -t 1 "clear" C-m

# C
sleep 1
clear
screenshot_rainbow "C1A"
screenshot_rainbow "C1B"
screenshot_rainbow "C1C"
screenshot_rainbow "C2"
script_complete "C"
tmux send-keys -t 2 "clear" C-m

# D
screenshot_rainbow "D"
screenshot_rainbow "D1"
script_complete "D"
tmux send-keys -t 3 "clear" C-m

# E
tmux send-keys -t 3 "./E.sh" C-m
screenshot_rainbow "E"
screenshot_rainbow "E1"
script_complete "E"
tmux send-keys -t 3 "clear" C-m

# F
tmux send-keys -t 3 "./F.sh" C-m
screenshot_rainbow "F"
screenshot_rainbow "F1"
script_complete "F"

# G
tmux send-keys -t 3 "./G.sh" C-m
script_complete "G"





