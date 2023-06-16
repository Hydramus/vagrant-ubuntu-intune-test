#!/bin/bash
set -e

echo "**** Begin installing Ubuntu, etc"

install_basic_packages() {
    sudo apt-get update -y
    sudo apt-get install -y wget gpg curl libplist-utils gnupg software-properties-common apt-transport-https
}

disable_needrestart() {
    sudo sh -c 'echo "nrconf{restart} = 'a';" >> /etc/needrestart/needrestart.conf'
}

add_google_chrome_repo() {
    wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
    echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" | sudo tee /etc/apt/sources.list.d/google.list
}

add_microsoft_edge_repo() {
    wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
    echo "deb [arch=amd64] https://packages.microsoft.com/repos/edge stable main" | sudo tee /etc/apt/sources.list.d/ms-edge.list
}

install_desktop_and_browser() {
    sudo apt-get update -y
    sudo apt-get upgrade -y
    echo "**** Begin installing ubuntu-desktop"
    sudo apt-get install -y ubuntu-desktop virtualbox-guest-dkms virtualbox-guest-utils virtualbox-guest-x11 google-chrome-stable microsoft-edge-stable
    echo "**** End installing ubuntu-desktop"
}

configure_time_zone() {
    sudo timedatectl set-timezone Europe/London
}

add_user_to_admin_group() {
    sudo usermod -a -G sudo vagrant
}

install_vs_code() {
    echo "**** Begin installing Visual Studio Code"
    wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
    sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
    echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" | sudo tee /etc/apt/sources.list.d/vscode.list
    sudo apt-get update
    sudo apt-get install code
    rm -f packages.microsoft.gpg
    echo "**** End installing Visual Studio Code"
}

install_microsoft_intune_app() {
    echo "**** Begin installing Microsoft Intune App"
    curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
    sudo install -o root -g root -m 644 microsoft.gpg /usr/share/keyrings/
    echo "deb [arch=amd64 signed-by=/usr/share/keyrings/microsoft.gpg] https://packages.microsoft.com/ubuntu/22.04/prod jammy main" | sudo tee /etc/apt/sources.list.d/microsoft-ubuntu-jammy-prod.list
    sudo apt-get update -y
    sudo apt-get install -y intune-portal
    rm microsoft.gpg
    echo "**** End installing Microsoft Intune App"
}

install_nodejs() {
    echo "**** Begin installing Node.js"
    curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
    sudo apt-get install -y nodejs
    echo "**** End installing Node.js"
}

main() {
    install_basic_packages
    disable_needrestart
    add_google_chrome_repo
    add_microsoft_edge_repo
    install_desktop_and_browser
    configure_time_zone
    add_user_to_admin_group
    install_vs_code
    install_microsoft_intune_app
    install_nodejs
    echo "**** End installing Ubuntu, etc"
    echo "**** I need to reboot cos Microsoft told me too (Intune app)"
    sudo shutdown -r now
}

main

