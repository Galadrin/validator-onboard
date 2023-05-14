#!/bin/bash
# Title: Router Validator Installation

# Clear the screen
clear

# Display the header
echo "---------------------------------"
echo " Router Chain Installer"
echo "---------------------------------"


# TODO: change this to GITHUB URL once made public
GIT_URL="https://bit.ly/45buAg2"
VALIDATOR_ONBOARD_URL="validator_onboard.py"

# Function to delete the script and the Python file
cleanup() {
    rm -- "$0"
    rm -- "${VALIDATOR_ONBOARD_URL}"
}

# TODO: uncomment trap, delete script once execution successful
# Catch exit signals and call the cleanup function
# trap cleanup EXIT

# Check if the system is Linux
if [[ "$(uname)" != "Linux" ]]; then
    echo "This script supports only Linux machines now."
    exit 1
fi

# Check if Python3 is installed
if ! command -v python3 &> /dev/null; then
    echo "Python3 is not installed. Do you want to install it? (yes/no)"
    read answer
    if [[ "${answer,,}" == "yes" ]]; then
        sudo apt-get update
        sudo apt-get install -y python3
    else
        echo "Python3 is required to run this script. Exiting."
        exit 1
    fi
fi

# Check if pip is installed
if ! command -v pip3 &> /dev/null; then
    echo "pip is not installed. Do you want to install it? (yes/no)"
    read answer
    if [[ "${answer,,}" == "yes" ]]; then
        sudo apt-get update
        sudo apt-get install -y python3-pip
    else
        echo "pip is required to run this script. Exiting."
        exit 1
    fi
fi

# Check if requests library is installed
if ! python3 -c "import requests" &> /dev/null; then
    echo "The requests library is not installed. Do you want to install it? (yes/no)"
    read answer
    if [[ "${answer,,}" == "yes" ]]; then
        pip3 install --user requests
    else
        echo "The requests library is required to run this script. Exiting."
        exit 1
    fi
fi

if command -v curl &> /dev/null; then
    curl -L -o "${VALIDATOR_ONBOARD_URL}" "${GIT_URL}"
elif command -v wget &> /dev/null; then
    wget -O "${VALIDATOR_ONBOARD_URL}" "${GIT_URL}"
else
    echo "curl or wget is required to download the Python script. Please install one of them and try again."
    exit 1
fi

# Run the validator_onboard.py script
python3 "${VALIDATOR_ONBOARD_URL}"