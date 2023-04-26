# CI PIPELINE SCRIPTS

This collection of scripts is designed to simplify the process of running CI pipelines. In addition to install_gcloud_cli.sh for installing the gcloud SDK, there are also scripts for running Terraform plan and validate commands (terraform_plan.sh and terraform_validate.sh), and plenty more will be coming soon.

These scripts are designed to be run in a CI environment and can help streamline the process of building and deploying applications.

## install_gcloud_cli.sh  

### Google Cloud SDK  

The Google Cloud SDK is a set of tools for managing resources and applications hosted on Google Cloud. For more information, please refer to the official documentation.

### Script Description
This bash script installs the gcloud SDK on Linux systems using apt-get, dnf, or apk depending on the detected package manager. The script is idempotent, meaning that it checks if gcloud is already installed before attempting to install it. If gcloud is already installed, the script will remind the user of the option to install components with arguments, but will not attempt to install the base package again.

### Usage
To use the script, simply run it in your terminal:
```
bash install_gcloud_cli.sh
```
This will install the base gcloud package. If you want to install one or more components, pass their names as arguments to the script:

```
bash install_gcloud_cli.sh kubectl
```
This will install the kubectl component in addition to the base gcloud package.

If gcloud is already installed and you want to install one or more components, run the script with the desired component names as arguments:

```
bash install_gcloud_cli.sh kubectl beta
```
This will install the kubectl and beta components.

**Note**: This script assumes that the user has sudo access and will prompt for the sudo password if necessary.

## terraform_plan.sh and terraform_validate.sh

### Terraform
Terraform is a tool for building, changing, and versioning infrastructure safely and efficiently. It can manage popular service providers as well as custom in-house solutions. For more information, please refer to the official documentation.

### Script Description
The terraform_plan.sh and terraform_validate.sh bash scripts simplify the process of running Terraform plan and validate commands in a CI pipeline. The scripts use find to locate all directories containing Terraform files (*.tf), change into each directory, and run the appropriate command. The scripts are idempotent and will exit with an error code if Terraform is not installed or no directories containing Terraform files are found.

### Usage
To use terraform_plan.sh, simply run it in your terminal:

```bash
bash terraform_plan.sh
```

This will run terraform plan in all directories containing Terraform files. You can also specify a specific directory or directories as arguments to the script:

```bash
bash terraform_plan.sh examples/us-west-1
```
To use terraform_validate.sh, run it in the same way:
```
bash terraform_validate.sh
```
This will run terraform validate in all directories containing Terraform files. You can also specify a specific directory or directories as arguments to the script:

```bash
bash terraform_validate.sh examples/us-west-1
```
Both scripts assume that Terraform is installed and available on the system path. If Terraform is not installed, the scripts will exit with an error code.