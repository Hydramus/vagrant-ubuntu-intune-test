#!/bin/bash
echo "**** Begin installing Ubuntu, etc"

# There are some requirements here from https://learn.microsoft.com/en-us/mem/intune/user-help/enroll-device-linux
# but also some other apps that might be useful in testing, feel free to add here for your needs or fun
# The purpose of doing it seperately in a script is to have a familiar syntax for the majority of you
# jsung - 2022/10/19

# Update repositories and some other basic applications
sudo apt update -y
sudo apt install -y wget gpg curl
# Add Google Chrome repository

wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub|sudo apt-key add -
sudo sh -c 'echo \"deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main\" > /etc/apt/sources.list.d/google.list'

# Downloading dependancies and repo for Microsoft Edge
sudo apt install software-properties-common apt-transport-https wget
wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
sudo sh -c 'echo \"deb [arch=amd64] https://packages.microsoft.com/repos/edge stable main\" > /etc/apt/sources.list.d/ms-edge.list'

# Update repositories again... just in case... should be a lot faster
sudo apt update -y

# Upgrade installed packages
sudo apt upgrade -y

echo "**** Begin installing ubuntu-desktop"
sudo apt install ubuntu-desktop -y

# Necessary if you are using virtualbox!
sudo apt install -y --no-install-recommends virtualbox-guest-dkms virtualbox-guest-utils virtualbox-guest-x11

sudo timedatectl set-timezone Europe/London

# Adding the default vagrant user into the admin group.
sudo usermod -a -G sudo vagrant

echo "**** End installing ubuntu-desktop"

# Add Google Chrome
sudo apt install -y google-chrome-stable

# Add Microsoft Edge
sudo apt install -y microsoft-edge-stable

echo "**** Begin installing Visual Studio Code"
#Install the apt repository and signing key to enable auto-updating using the system's package manager
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
rm -f packages.microsoft.gpg

#Update the package cache and install the package
sudo apt install -y apt-transport-https
sudo apt update
sudo apt install code
echo "**** End installing Visual Studio Code"

echo "**** Begin installing Microsoft Intune App" # why is this still called intune? lol.

# For Ubuntu 22.04, see the path! Probably could do a variable based on OS major release later...
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo install -o root -g root -m 644 microsoft.gpg /usr/share/keyrings/
sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/microsoft.gpg] https://packages.microsoft.com/ubuntu/22.04/prod jammy main" > /etc/apt/sources.list.d/microsoft-ubuntu-jammy-prod.list'
sudo rm microsoft.gpg

# Install the Microsoft Intune app
sudo apt update -y
sudo apt install -y intune-portal

echo "**** Begin installing Node.js"
# Using Ubuntu
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt-get install -y nodejs
echo "**** End installing Node.js"

echo "**** End installing Ubuntu, etc"