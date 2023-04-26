#!/bin/bash

set -euo pipefail

# Determine which package manager to use based on available commands
if command -v apt-get >/dev/null 2>&1; then
  PACKAGE_MANAGER="apt-get"
elif command -v dnf >/dev/null 2>&1; then
  PACKAGE_MANAGER="dnf"
elif command -v apk >/dev/null 2>&1; then
  PACKAGE_MANAGER="apk"
else
  echo "Error: No supported package manager found."
  exit 1
fi

# Install required packages
echo "Installing required packages with $PACKAGE_MANAGER..."
sudo $PACKAGE_MANAGER update
if [ "$PACKAGE_MANAGER" == "apk" ]; then
  sudo $PACKAGE_MANAGER add -U kubectl
else
  sudo $PACKAGE_MANAGER install -y kubectl
fi

# Get a list of all node names
nodes=$(kubectl get nodes -o jsonpath='{.items[*].metadata.name}' | tr ' ' '\n' | sort -u)

# Loop through each node and get the pods running on it
for node in $nodes; do
  pods=$(kubectl get pods --all-namespaces -o wide --field-selector=spec.nodeName="$node" | tail -n +2)

  # Print information about the pods on this node
  echo "Pods running on node: $node"
  if [ -z "$pods" ]; then
    echo "No pods found on node: $node"
  else
    echo "$pods"
  fi
done
