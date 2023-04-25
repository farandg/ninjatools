## Use this bash script to produce a list of pods per node. Best with grep
#!/bin/bash

set -euo pipefail

nodes=$(kubectl get nodes -o jsonpath='{.items[*].metadata.name}' | tr ' ' '\n' | sort -u)

for node in $nodes; do
  pods=$(kubectl get pods --all-namespaces -o wide --field-selector=spec.nodeName="$node")

  echo "Pods running on node: $node"
  if [ -z "$pods" ]; then
    echo "No pods found on node: $node"
  else
    echo "$pods"
  fi
done
