## pods_on_nodes.sh

### kubectl

Kubernetes is an open-source container orchestration platform that automates deploying, scaling, and operating application containers. The kubectl command-line tool allows you to run commands against Kubernetes clusters. For more information, please refer to the official documentation.

### Script Description

This bash script lists all pods running on each node in a Kubernetes cluster. If kubectl isn't present on the machine, the script first determines which package manager to use (apt-get, dnf, or apk) based on the available commands on the system. It then installs the kubectl command-line tool if it is not already installed. After this, it retrieves a list of all node names in the cluster and loops through each node to get the pods running on it.

### Usage

To use the script, simply run it in your terminal:

```bash
bash pods_on_nodes.sh
```
The script will output the pods running on each node in the Kubernetes cluster.

**Note**: This script assumes that the user has sudo access and will prompt for the sudo password if necessary.