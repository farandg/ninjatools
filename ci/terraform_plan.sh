#!/bin/bash

set -e

# Check if terraform is installed
if ! command -v terraform &> /dev/null; then
    echo "Error: terraform is not installed."
    exit 1
fi

# Find directories containing *.tf files and store them in a variable
if [ $# -eq 0 ]; then
    TF_DIRS=$(find . -type f -iname "*.tf" -exec dirname {} \; | sort -u)
else
    TF_DIRS="$@"
fi

# Exit 1 if no directories are found
if [ -z "$TF_DIRS" ]; then
  echo "Error: No Terraform files (*.tf) found."
  exit 1
fi

echo "Directories containing Terraform files:"
echo "$TF_DIRS"

# Iterate over the directories
for dir in $TF_DIRS; do
  echo "-------------------------------------------"
  echo "Checking directory: $dir"
  
  # Change to the directory and run terraform commands
  if ! cd "$dir" || ! terraform init || ! terraform plan; then
    echo "Error: Failed to plan directory: $dir"
    exit 1
  fi

  echo "Terraform planning successful in directory: $dir"
  cd - > /dev/null || exit 1
done

echo "-------------------------------------------"
echo "Terraform planning complete."
