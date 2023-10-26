#!/bin/bash
#B.sh

source setup.sh

#Clone Your Repository On Your Local Machine
#B.  Clone your remote repository to your local machine using the command line interface. Include a screenshot of the command line action and be sure to have your repository name visible in the command prompt.


# If the repo exists already get rid of it
clear_tmp_files "B"
rm -rf ${REPO_NAME} ${ZIP_FILE}

# Give mux a second
sleep 1

# Start waiting_rainbow
script_rainbow "A"

#clear before we start
execute_command "clear"


# Clone the Git repository
execute_command "git clone ${STUDENT_PROJECT_REPO_URL}"
#
# Move into the repository directory 
execute_command "cd ${REPO_NAME} || exit 1"

execute_command "pwd"
execute_command "ls -a"

# Download the file using curl
execute_command "curl -o ${ZIP_FILE} ${FILE_URL}"

# Check if the download was successful
if [ $? -eq 0 ]; then
  # Unzip the downloaded file to the current directory
  execute_command "unzip -q ${ZIP_FILE}"

  # Check if the unzip was successful
  if [ $? -eq 0 ]; then
    # Delete the original zip file
    rm "$ZIP_FILE"
    echo "Downloaded, unzipped, and deleted $ZIP_FILE"
  else
    echo "Failed to unzip $ZIP_FILE"
  fi
else
  echo "Failed to download $ZIP_FILE"
fi

execute_command "pwd"
execute_command "ls -a"
screenshot_ready "B"



