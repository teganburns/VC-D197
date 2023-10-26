#!/bin/bash
#setup.sh

# Environment variable values
STUDENT_PROJECT_REPO_URL='https://gitlab.com/teganburns/010425196_d197.git'
STUDENT_ID="010425196"

# Constant Variables
REPO_NAME=$(basename "$STUDENT_PROJECT_REPO_URL" .git)
FILE_URL="https://storage.googleapis.com/personal_projects/portfolio/WGU-D197/WGU-Hub.zip"
ZIP_FILE="WGU-Hub.zip"

# Export the environment variables
export STUDENT_PROJECT_REPO_URL
export STUDENT_ID
export REPO_NAME
export FILE_URL 
export ZIP_FILE 

# Define an array with screenshot steps/name
screenshot_file_suffixes=("A3" "B" "C1A" "C1B" "C1C" "C2" "D" "D1" "E" "E1" "F" "F1")

# Function that sleeps for a specified number of seconds and clears the screen
sleep_and_clear() {
    local seconds="$1"

    # Check if the argument is a valid number
    if [[ ! "$seconds" =~ ^[0-9]+$ ]]; then
        echo "Invalid input. Please provide a valid number of seconds."
        return 1
    fi

    # Sleep for the specified number of seconds
    sleep "$seconds"

    # Clear the terminal screen
    clear
}
#
# Function to ask a yes/no question
ask_yes_no() {
    local question="$1"
    local response
    while true; do
        read -p "$question (yes/no): " response
        case $response in
            [Yy]* ) return 0;; # "yes"
            [Nn]* ) return 1;; # "no"
            * ) echo "Please answer yes or no.";;
        esac
    done
}


# Get the current username (or prefix)
CURRENT_USERNAME=$(whoami)

RED='\033[0;31m'
CYAN='\033[0;36m'
NC='\033[0m'

# Define your custom prompt with the username and dollar sign
CUSTOM_PROMPT="${CYAN}${CURRENT_USERNAME}\$ ${NC}"
PS1=$CUSTOM_PROMPT 

export RED
export CYAN
export NC
export CURRENT_USERNAME
export PS1

# Function to execute a command with the custom prompt
execute_command() {
    local COMMAND="$1"
    # Display the custom prompt followed by the command
    echo -e -n "${CUSTOM_PROMPT}${COMMAND}\n"

    # Execute the command
    eval "$COMMAND"
}

fake_execute_command() {
  echo -e "$PS1$1"
}


check_image_file() {
    local prefix="$1"  # The argument passed to the function
    local image_extensions=("/tmp/$prefix" "/tmp/${prefix}.png" "/tmp/${prefix}.jpg" "/tmp/${prefix}.jpeg")

    for ext in "${image_extensions[@]}"; do
        if [ -f "$ext" ]; then
            echo "Found image file: $ext"
            return 0  # Success
        fi
    done
    #echo "ERROR: No image file found in the current directory!"
    return 1  # Failure
}


remove_image_file() {
    local prefix="$1"  # The argument passed to the function
    local image_extensions=("/tmp/$prefix" "/tmp/${prefix}.png" "/tmp/${prefix}.jpg" "/tmp/${prefix}.jpeg")

    for ext in "${image_extensions[@]}"; do
        if [ -f "$ext" ]; then
            echo "Image file removed: $ext"
            rm $ext
            return 0  # Success
        fi
    done
    #echo "ERROR: No image file found in the current directory!"
    return 1  # Failure
}



# Global variable to keep track of the starting color index
starting_color_index=0

rainbow_text() {
    # Define ANSI escape codes for the rainbow colors
    local RED='\033[0;31m'
    local ORANGE='\033[0;33m'
    local YELLOW='\033[1;33m'
    local GREEN='\033[0;32m'
    local BLUE='\033[0;34m'
    local PURPLE='\033[0;35m'
    local NC='\033[0m'  # No color

    # Array to hold the rainbow colors
    local colors=("$RED" "$ORANGE" "$YELLOW" "$GREEN" "$BLUE" "$PURPLE")

    # Get the string from the argument
    local str="$1"
    local output=""

    # Loop through each character in the string
    for (( i=0; i<${#str}; i++ )); do
        # Get a single character from the string
        local char="${str:$i:1}"

        # Determine which color to use, taking the starting color index into account
        local color_index=$(((i + starting_color_index) % 6))
        local color="${colors[$color_index]}"

        # Add the colored character to the output
        output+="${color}${char}${NC}"
    done

    # Display the rainbow text
    echo -ne "$output\r"

    # Update the starting color index for the next call
    starting_color_index=$(((starting_color_index + 1) % 6))
}


script_rainbow() {
    script_name=$1

    # Initialize counter variable
    count=0

    # Loop with counter condition
    while [ ! -f "/tmp/script.${script_name}.complete" ]; do

        # Check if count has reached 1200 and exit with a message if it has
        if [[ $count -eq 1200 ]]; then
            clear
            echo -e "\033[0;31mTimeout, completion file not found.\033[0m"
            exit 1
        fi

        remaining_time=$(( ( 1200 - count ) / 20))
        rainbow_text "Waiting ${remaining_time} seconds for script ${script_name} to complete..."

        # Increment the counter
        count=$((count + 1))
        sleep 0.05
    done
}


screenshot_rainbow() {
  arg=$1
  tmp_file="/tmp/screenshot.${arg}.tmp"
  png_file="/tmp/${arg}.png"

  # Initialize counter variable
  count=0

  # while loop will wait for a tmp file indicating it should take a screenshot
  # loop exits itself after 60 seconds
  while [ ! -f "$tmp_file" ]; do

    # Check if count has reached 1200 and exit with a message if it has
    if [[ $count -eq 1200 ]]; then
      clear
      echo -e "\033[0;31mTimeout, screenshot not taken.\033[0m"
      exit 1
    fi

    remaining_time=$(( ( 1200 - count ) / 20))
    rainbow_text "Waiting ${remaining_time} seconds to take screenshot ${png_file} ..."

    # Increment the counter
    count=$((count + 1))
    sleep 0.05
  done

  # Check if the file exists
  if [[ -e "$tmp_file" ]]; then
    # take a screenshot and remove tmp file
    screencapture -i "$png_file"
    rm "$tmp_file"
  fi
}

script_complete() { 
  touch "/tmp/script.$1.complete"
}

screenshot_ready() {
  touch "/tmp/screenshot.$1.tmp"
}

clear_tmp_files() {
  rm "/tmp/screenshot.$1.tmp" 2>/dev/null
  rm "/tmp/script.$1.complete" 2>/dev/null
  rm "/tmp/$1.png" 2>/dev/null
}


