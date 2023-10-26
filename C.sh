#!/bin/bash
#C.sh

source setup.sh


#Make Changes, Commit, and Push
#C.  Modify three HTML files you choose on the master branch by the doing the following:
#1.  Commit each change with a short, meaningful message that explains all changes you have made to the three HTML files. Include a screenshot for each git command for each change and be sure to have your repository name visible in the command prompt.
#2.  Push the branch to GitLab. Include a screenshot of the command line action and be sure to have your repository name visible in the command prompt.


clear_tmp_files "C"
clear_tmp_files "C1A"
clear_tmp_files "C1B"
clear_tmp_files "C1C"
clear_tmp_files "C2"

# Give mux a second
sleep 1

# Wait for script B to finish
script_rainbow "B"

# Move into the repository directory or exit
execute_command "cd ${REPO_NAME} || exit 1"


# Fluff to make it look real (optional)
clear
execute_command "pwd"
execute_command "ls -a"

# Find and process the first three HTML files in the current directory
count=0
for file in *.html; do
  if [ "$count" -lt 3 ]; then
    # Check if the file exists and is a regular file
    if [ -f "$file" ]; then
      # Add a comment to the top of the file
      echo "<!-- Modified by $STUDENT_ID -->" | cat - "$file" > temp && mv temp "$file"
      fake_execute_command "vim $file"

      #execute_command "pwd && ls -a"

      execute_command "git rev-parse --show-toplevel"
      execute_command "git add *"
      execute_command "git commit -m \"Added comment to $file\" "
      execute_command ""

            # Use a case statement to check its value
            case "$count" in
              0)
                screenshot_ready "C1A"
                ;;
              1)
                screenshot_ready "C1B"
                ;;
              2)
                screenshot_ready "C1C"
                ;;
              *)
                # Code to execute for other values
                # Should never happen
                ;;
            esac

            screenshot_paths=( "/tmp/screenshot.C1A.tmp" "/tmp/screenshot.C1B.tmp" "/tmp/screenshot.C1C.tmp" )
            # Use a while loop to check if any of the file paths exist
            tmp_cnt=0
            while [ ${#screenshot_paths[@]} -gt 0 ]; do
              current_path="${screenshot_paths[0]}"  # Get the first path

              if [ ! -e "$current_path" ]; then
                # Remove the checked path from the array
                screenshot_paths=("${screenshot_paths[@]:1}")
              fi


                # Add a delay before checking the next path (1 second in this example)
                sleep 0.05
              done
              clear
              ((count++))
    fi
  else
    break  # Exit the loop after processing three files
  fi
done

# C2
clear


execute_command "git rev-parse --show-toplevel"
execute_command "git add *"
execute_command "git push"
screenshot_ready "C2"

