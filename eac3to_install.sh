#!/bin/bash
#Debian 11 eac3to install script, meant for dedicated seedboxes or vps's with root
#save to a file with .sh extension and run 'chmod +x file.sh' and 'sudo ./file.sh' or 
#Run with sudo
#Installs unzip, wine and eac3to
#This does not include any updated eac3to ddls
 
if [ "$EUID" -ne 0 ]
  then echo "Please run with sudo"
  exit
fi
 
#Get user
USER=$(cut -d: -f1 < /root/.master.info)
 
#install unzip
sudo apt install unzip
 
#install wine
sudo sh -c 'echo " deb https://dl.winehq.org/wine-builds/debian/ bullseye main" >> /etc/apt/sources.list.d/wine.list'
wget -nc https://dl.winehq.org/wine-builds/winehq.key
sudo apt-key add winehq.key
sudo dpkg --add-architecture i386
apt update
apt install --install-recommends winehq-stable
 
#install eac3to
curl -L http://madshi.net/eac3to.zip -o /home/${USER}/eac3to.zip
unzip /home/${USER}/eac3to.zip -d /home/${USER}/eac3to
rm /home/${USER}/eac3to.zip
 
#add alias
echo "alias eac3to='wine /home/${USER}/eac3to/eac3to.exe 2>/dev/null'" >> /home/${USER}/.bashrc
source /home/${USER}/.bashrc
 
#change eac3to folder from root to user
sudo chown -R ${USER}:${USER} /home/${USER}/eac3to
 
echo Done
