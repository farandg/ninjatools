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

## authenticate_to_clusters.py

This script automates the process of retrieving Google Kubernetes Engine (GKE) cluster credentials for multiple projects and zones. It reads the cluster information from a separate file, allowing you to share the script without exposing your cluster information.

### Requirements

*Python 3.x
*Google Cloud SDK installed and configured

### Usage

Create a file named clusters.txt in the same directory as the script.
Add your cluster information to the clusters.txt file in the following format, one per line:

```bash
<cluster-name>:<project-id>:<zone>
```

Each line should contain a single cluster's information. For example:

```bash
development-cluster:dev-project-123456:europe-west1
production-cluster:prod-project-123456:europe-west1
``` 

Run the script:
```bash
python3 cluster_credentials_retriever.py
```

You will be prompted to confirm the retrieval of credentials for each cluster. To automatically answer "yes" to all prompts, use the -y or --yes option:

```bash
python3 cluster_credentials_retriever.py --yes
```

Example
Suppose your clusters.txt file contains the following information:

``` bash
development-cluster:dev-project-123456:europe-west1
production-cluster:prod-project-123456:europe-west1
```

When you run the script, you will be prompted to confirm the retrieval of credentials for each cluster:

```bash
Get credentials for cluster: development-cluster (y/n)? y
Getting credentials for cluster: development-cluster
Get credentials for cluster: production-cluster (y/n)? n
``` 

In this example, the script will retrieve credentials for the development-cluster and skip the production-cluster.

After running the script, the GKE cluster credentials will be available in your local kubectl configuration.  