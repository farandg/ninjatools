#!/bin/bash

set -e

# Determine the package manager based on the distro
detect_package_manager() {
  if command -v apt-get >/dev/null 2>&1; then
    echo "apt-get"
  elif command -v yum >/dev/null 2>&1; then
    echo "yum"
  elif command -v dnf >/dev/null 2>&1; then
    echo "dnf"
  elif command -v pacman >/dev/null 2>&1; then
    echo "pacman"
  else
    echo "Error: Unable to determine package manager for this system."
    exit 1
  fi
}

# Check and install a dependency if it is not installed
check_dependency() {
  local dependency="$1"
  local package_manager="$2"

  echo "Checking for $dependency..."
  if ! command -v "$dependency" >/dev/null 2>&1; then
    echo "$dependency not found. Installing..."
    case "$package_manager" in
      apt-get)
        sudo apt-get update
        sudo apt-get install -y "$dependency"
        ;;
      yum)
        sudo yum install -y "$dependency"
        ;;
      pacman)
        sudo pacman -Syu --noconfirm "$dependency"
        ;;
      *)
        echo "Error: Unsupported package manager."
        exit 1
        ;;
    esac
  else
    echo "$dependency is already installed."
  fi
}

package_manager=$(detect_package_manager)

# Check if python3-pip is installed, if not install it
check_dependency "python3-pip" "$package_manager"

# Upgrade pip and install pipreqs
pip install --upgrade pip pipreqs

# Find all directories containing Python files
PY_DIRS=$(find . -type f -iname "*.py" -exec dirname {} \; | sort -u)

# Exit 1 if no Python directories are found
if [ -z "$PY_DIRS" ]; then
  echo "Error: No Python files (*.py) found."
  exit 1
fi

echo "Python directories containing *.py files:"
echo "$PY_DIRS"

# Install requirements for each Python directory
for dir in $PY_DIRS; do 
    echo "-------------------------------------------"
    echo "Checking directory: $dir"
  
    # Change to the directory and install the requirements
    if ! cd "$dir" || ! [ -f requirements.txt ]; then
        echo "Error: Failed to find requirements.txt or change directory: $dir"
        exit 1
    fi

    echo "Installing requirements for: $dir"
    pip install --trusted-host pypi.org -r requirements.txt || {
        echo "Error: Failed to install requirements for: $dir"
        exit 1
    }

    cd - > /dev/null || exit 1
done

echo "-------------------------------------------"
echo "Finished installing Python requirements."
