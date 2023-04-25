#!/bin/bash

set -euo pipefail

# Find all directories containing *.tf files and store them in a variable
TF_DIRS=$(find . -type f -iname "*.tf" -exec dirname {} \; | sort -u)

# Exit 1 if no directories are found
if [ -z "$TF_DIRS" ]; then
  echo "Error: No Terraform files (*.tf) found."
  exit 1
fi

echo "Directories containing Terraform files:"
echo "$TF_DIRS"

# Iterate over the directories
for dir in $TF_DIRS; do
  echo "-----------------------------------------"
  echo "Checking directory: $dir"
  
  # Change to the directory and run terraform commands
  if ! cd "$dir"; then
    echo "Error: Failed to check directory: $dir"
    continue
  fi

  # Run terraform init
  echo "Running terraform init..."
  if ! terraform init; then
    echo "Error: terraform init failed in directory: $dir"
    cd - > /dev/null || exit 1
    continue
  fi

  # Run terraform plan
  echo "Running terraform plan..."
  if ! terraform plan; then
    echo "Error: terraform plan failed in directory: $dir"
  else
    echo "Terraform plan successful in directory: $dir"
  fi

  cd - > /dev/null || exit 1
done

echo "-----------------------------------------"
echo "Terraform planning complete."
