#!/bin/bash

# Check if the required number of arguments are provided
if [ "$#" -ne 2 ]; then
  echo "Error: Invalid number of arguments."
  echo "Usage: $0 <file_name> <pattern>"
  exit 1
fi

# Check if the input file exists
if [ ! -f "$1" ]; then
  echo "Error: File '$1' does not exist."
  exit 1
fi

# Backup the original file
cp "$1" "${1}.bak"

# Delete lines starting with the pattern in the given file
sed -i.bak "/^$2/d" "$1"

# Print success message
echo "Lines starting with pattern '$2' have been deleted from file '$1'."
echo "A backup of the original file has been saved as '${1}.bak'."
