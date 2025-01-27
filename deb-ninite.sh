#!/bin/bash

#Titel: Ninite clone für fresh Debian12 Install
#Aktualisiert: 24-01-2025
#Author: Merlin Krämer

#Root all the things
if [[ $EUID -ne 0 ]]; then
   echo "Install as root!" 
   exit 1
fi

# Update and install essentials
echo "Updating package list and installing dependencies..."
apt update && apt upgrade -y
sudo install -d -m 0755 /etc/apt/keyrings 
sudo apt install -y software-properties-common apt-transport-https wget gpg snapd coreutils sudo bash-completion net-tools gnupg2 curl wget vim git htop lsof tree unzip zip
sudo snap install snapd -y
sudo apt install flatpak -y
sudo apt install gnome-software-plugin-flatpak
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
sudo apt install -y gnome-software-plugin-snap
update-desktop-database ~/.local/share/applications/
update-desktop-database /usr/share/applications/

# Install Firefox Nightly source
echo "Grabbing Firefox Nightly source..."
wget -q https://packages.mozilla.org/apt/repo-signing-key.gpg -O- | sudo tee /etc/apt/keyrings/packages.mozilla.org.asc > /dev/null
gpg -n -q --import --import-options import-show /etc/apt/keyrings/packages.mozilla.org.asc | awk '/pub/{getline; gsub(/^ +| +$/,""); print "\n"$0"\n"}'
echo "deb [signed-by=/etc/apt/keyrings/packages.mozilla.org.asc] https://packages.mozilla.org/apt mozilla main" | sudo tee -a /etc/apt/sources.list.d/mozilla.list > /dev/null

# Install Alacritty
echo "Grabbing Alacritty source..."
sudo snap install alacritty --classic

# Install Chromium
echo "Installing Chromium..."
sudo snap install chromium

# Install Thunderbird
echo "Installing Thunderbird..."
apt install -y thunderbird

# Install Obsidian
echo "Installing Obsidian via snap..."
sudo snap install obsidian --classic

# Install Syncthing
echo "Installing Syncthing..."
wget -qO- https://syncthing.net/release-key.txt | gpg --dearmor > /usr/share/keyrings/syncthing.gpg
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/syncthing.gpg] https://apt.syncthing.net/ syncthing stable" > /etc/apt/sources.list.d/syncthing.list

# Start Syncthing at startup for $USER
sudo systemctl enable syncthing@$USER.service

# Install FileZilla
echo "Installing FileZilla..."
apt install -y filezilla

# Install Bitwarden
echo "Installing Bitwarden..."
sudo snap install bitwarden

# Install Thunar
echo "Installing Thunar file manager..."
apt install -y thunar

#Install Gimp
echo "Installing via flatpak..."
echo "Gimp..."
latpak install flathub org.gimp.GIMP -y
echo "Chatterino..."
flatpak install flathub com.chatterino.chatterino -y
echo "Spotify..."
flatpak install flathub com.spotify.Client -y
echo "OBS..."
flatpak install flathub com.obsproject.Studio -y
echo "VLC..."
flatpak install flathub org.videolan.VLC -y
echo "Discord..."
flatpak install flathub com.discordapp.Discord -y
echo "WhatsApp (Whatsie)..."
flatpak install flathub com.ktechpit.whatsie -y
echo "Teams..."
flatpak install flathub com.github.IsmaelMartinez.teams_for_linux -y
echo "GoogleChrome..."
flatpak install flathub com.google.Chrome -y
echo "VSCode..."
flatpak install flathub com.visualstudio.code -y


echo "---flatpak done---"

# FONT
echo "Installing fonts..."
echo "JetBrainsMono NerdFont & Cousine NerdFont"
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/Cousine.zip -O /tmp/Cousine.zip && unzip /tmp/Cousine.zip -d /tmp/Cousine && sudo cp -n /tmp/Cousine/*.ttf /usr/share/fonts/ && wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/JetBrainsMono.zip -O /tmp/JetBrainsMono.zip && unzip /tmp/JetBrainsMono.zip -d /tmp/JetBrainsMono && sudo cp -n /tmp/JetBrainsMono/*.ttf /usr/share/fonts/ && sudo fc-cache -fv && rm -rf /tmp/Cousine /tmp/Cousine.zip /tmp/JetBrainsMono /tmp/JetBrainsMono.zip


#ZSH
echo "Installing ZSH..."
sudo apt install zsh -y
echo "Making ZSH default Shell..."
sudo chsh -s $(which zsh)
# echo "Installing oh-my-zsh"
# sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
echo "installing eza..."
wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
sudo apt update
sudo apt install -y eza
echo "install zsh-auto-suggestions..."
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
echo "zsh-syntax-highlighting..."
sudo apt install zsh-syntax-highlighting
echo "source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ${ZDOTDIR:-$HOME}/.zshrc


# Install I3, i3wm-lock
echo "Installing I3 & i3-lock via Snap..."
sudo apt install i3 -y
sudo snap install i3wm-lock --edge
sudo apt install rofi -y

# Update package list and install applications
echo "Updating package sources..."
apt update

echo "Installing packages..."
apt install -y code google-chrome-stable syncthing firefox-nightly

# Clean up temporary files
echo "Cleaning up..."
rm -f /tmp/firefox-nightly.tar.bz2

echo "--------------------------- Done!----------------------------"
read -p "Do you want to reboot now? (Y/N): " choice

# Reboot Y/N
case "$choice" in
    [Yy]|[Yy][Ee][Ss]) # Accepts Y, y, Yes, yes
        echo "Rebooting now..."
        sudo reboot
        ;;
    [Nn]|[Nn][Oo]) # Accepts N, n, No, no
        echo "Reboot canceled. Exiting script."
        ;;
    *)
        echo "Invalid input. Please enter Y or N."
        ;;
esac
