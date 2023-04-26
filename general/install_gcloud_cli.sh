#!/bin/bash

# Check if gcloud is already installed
if command -v gcloud &>/dev/null; then
    # If one or more arguments are passed, install the components
    if [ $# -gt 0 ]; then
        echo "Installing gcloud components: $@..."
        gcloud components install "$@"
        exit $?
    fi
    
    echo "gcloud is already installed."
    echo "To install a specific component, pass its name(s) as an argument to this script."
    exit 0
fi

# Detect package manager
if command -v apt-get &>/dev/null; then
    PACKAGE_MANAGER="apt-get"
elif command -v dnf &>/dev/null; then
    PACKAGE_MANAGER="dnf"
elif command -v apk &>/dev/null; then
    PACKAGE_MANAGER="apk"
else
    echo "Unable to detect package manager. Please install gcloud manually."
    exit 1
fi

# Install the gcloud SDK
echo "Installing gcloud..."
case "$PACKAGE_MANAGER" in
    apt-get)
        export CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)"
        echo "deb http://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
        curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
        sudo apt-get update && sudo apt-get install google-cloud-sdk
        ;;
    dnf)
        sudo dnf install google-cloud-sdk
        ;;
    apk)
        sudo apk add google-cloud-sdk
        ;;
esac

# If one or more arguments are passed, install the components
if [ $# -gt 0 ]; then
    echo "Installing gcloud component(s): $@..."
    gcloud components install "$@"
    exit $?
fi

# Verify installation
if command -v gcloud &>/dev/null; then
    echo "gcloud has been successfully installed."
    echo "To install one or more components, pass the names as arguments to this script."
    echo "Example: bash install_gcloud_cli.sh kubectl"
    exit 0
else
    echo "There was an error installing gcloud."
    exit 1
fi
