#!/bin/bash


# Define the catter function
function catter() {
  cat "$1"
}

# Export the function so it can be used in the subshell
export -f catter

# Loop through JSON and YAML files, excluding the .git directory
find dir1 dir2 -type f -not -path "./.git/*" -exec bash -c '
    echo "Processing file: $1"
    # Add your file processing logic here
    catter $1
' _ {} \;
