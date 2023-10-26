#!/bin/bash

source setup.sh


clear_tmp_files "G"

# Give mux a second
sleep 1

# Wait for script F to finish
script_rainbow "F"

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

mkdir retrospective
git log > retrospective/log.txt
echo "1) To resolve this merge conflict in E1 I just deleted lines 1-5. 2) In part C I added <!-- Modified by STUDENT_ID --> to the top of three html files in the directory (*.html)." > retrospective/summary.txt
pdflatex ../mydocument.tex && mv mydocument.pdf retrospective/screenshots.pdf && rm mydocument.aux mydocument.log

clear

fake_execute_command "mkdir retrospectivei && git log > retrospective/log.txt"
fake_execute_command "vim retrospective/summary.txt"
execute_command "git add *"
execute_command "git commit -m \"G 1-5\""
execute_command "git push"

echo "Good job now let the it timeout b/c i got too lasy to code this part"
