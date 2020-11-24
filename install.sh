#!/bin/bash
 
# Updated 2019-09-17

BRANCH='master'

BLUE='\033[0;34m'
CYAN='\033[0;36m'
RED='\033[0;31m'
NC='\033[0m' # [n]o color

BOLD='\033[1m'

echo "Welcome to the"
echo "${CYAN}${BOLD}Dorsa \"$BRANCH\" installation!${NC}"
echo "${CYAN}${BOLD}Please wait...!${NC}"

# Disable Screensaver
echo "${BLUE}${BOLD}Disabling Screensaver!${NC}"
sudo xset s off
sudo xset -dpms
sudo xset s noblank

# Installing system dependencies
echo "${BLUE}${BOLD}Installing system dependencies!${NC}"
echo "${BLUE}${BOLD}    - Updating Raspberry Pi!${NC}"
sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get dist-upgrade -y
echo "${BLUE}${BOLD}    - Updating iptables!${NC}"
echo iptables-persistent iptables-persistent/autosave_v4 boolean true | sudo debconf-set-selections
echo iptables-persistent iptables-persistent/autosave_v6 boolean true | sudo debconf-set-selections
echo "${BLUE}${BOLD}    - Installing iptables-persistent!${NC}"
sudo apt-get install -y iptables-persistent
echo "${BLUE}${BOLD}    - Installing libatlas-base-dev!${NC}"
sudo apt-get install -y libatlas-base-dev
echo "${BLUE}${BOLD}    - numlockx!${NC}"
sudo apt-get install -y numlockx
echo "${BLUE}${BOLD}    - Installing pulseaudio-dev!${NC}"
sudo apt-get install portaudio19-dev libsox-fmt-mp3 pulseaudio -y
pulseaudio -D

# Creating Directory for Dorsa
echo "${BLUE}${BOLD}Creating Directory for Dorsa!${NC}"
echo "${BLUE}${BOLD}    - mkdir /dorsa!${NC}"
sudo mkdir /dorsa
echo "${BLUE}${BOLD}    - chown $USER /dorsa!${NC}"
sudo chown $USER /dorsa

# Linking ssh key to access package github repo
echo "${BLUE}${BOLD}Linking ssh key to access package github repo!${NC}"
echo "${BLUE}${BOLD}    - downloading Dorsa SSH key!${NC}"
wget https://bit.ly/dorsa_ssh
sudo mv ~/dorsa_ssh /dorsa/ssh-key
mkdir /home/pi/.ssh
ln -s /dorsa/ssh-key /home/pi/.ssh/id_rsa
echo "Host *\n\tStrictHostKeyChecking no" > /home/pi/.ssh/config
sudo chmod 755 /home/pi/.ssh
sudo chmod 400 /home/pi/.ssh/config
sudo chmod 600 /home/pi/.ssh/id_rsa
sudo chmod 600 /dorsa/ssh-key

# Clone repository from Github and copy files
echo "${BLUE}${BOLD}Clone repository from Github and copy files!${NC}"
echo "${BLUE}${BOLD}    - Cloning Repo!${NC}"
git clone -b $BRANCH ssh://git@github.com/crowdbotics/dorsa_rpi_package /dorsa/tempDorsa
echo "${BLUE}${BOLD}    - Copying Launcher.sh!${NC}"
sudo mv /dorsa/tempDorsa/dorsa/Others/Launcher.sh /dorsa/Launcher.sh
sudo chmod 775 /dorsa/Launcher.sh
echo "${BLUE}${BOLD}    - Updating /dorsa/dorsa!${NC}"
sudo cp /dorsa/tempDorsa/dorsa/dorsa.py /dorsa/dorsa
echo "${BLUE}${BOLD}    - Copying Shortcuts!${NC}"
sudo cp /dorsa/tempDorsa/dorsa/Others/listen.desktop /dorsa/listen.desktop
sudo cp /dorsa/tempDorsa/dorsa/Others/update.desktop /dorsa/update.desktop
sudo cp /dorsa/tempDorsa/dorsa/Others/log.desktop /dorsa/log.desktop
sudo chmod 775 /dorsa/dorsa

# Creating shortcut on Desktop
echo "${BLUE}${BOLD}Creating shortcut on Desktop!${NC}"
sudo ln -s /dorsa/dorsa /usr/local/bin/
ln -s /dorsa/listen.desktop /home/pi/Desktop/
ln -s /dorsa/update.desktop /home/pi/Desktop/
ln -s /dorsa/log.desktop /home/pi/Desktop/

# Installing Seeed Studio Mic Driver
git clone https://github.com/respeaker/seeed-voicecard.git
cd seeed-voicecard
sudo ./install.sh
cd ~


# Installing dorsa environment dependencies
echo "${BLUE}${BOLD}Installing dorsa environment dependencies!${NC}"
python3 -m venv /dorsa/env
echo "${BLUE}${BOLD}    - downgrading pip!${NC}"
sudo /dorsa/env/bin/python -m pip install pip==9.0.1
echo "${BLUE}${BOLD}    - updating setuptools!${NC}"
sudo /dorsa/env/bin/python -m pip install --upgrade setuptools
sudo /dorsa/env/bin/python -m pip install -U setuptools
echo "${BLUE}${BOLD}    - Installing wheel!${NC}"
sudo /dorsa/env/bin/python -m pip install wheel
echo "${BLUE}${BOLD}    - Installing google-cloud-texttospeech!${NC}"
sudo /dorsa/env/bin/python -m pip install --upgrade google-cloud-texttospeech
echo "${BLUE}${BOLD}    - Installing google-api-python-client!${NC}"
sudo /dorsa/env/bin/python -m pip install --upgrade google-api-python-client
echo "${BLUE}${BOLD}    - Installing google-cloud-speech!${NC}"
sudo /dorsa/env/bin/python -m pip install --upgrade google-cloud-speech
echo "${BLUE}${BOLD}    - Installing google-auth!${NC}"
sudo /dorsa/env/bin/python -m pip install --upgrade google-auth
echo "${BLUE}${BOLD}    - Installing Pillow!${NC}"
sudo /dorsa/env/bin/python -m pip install pillow==6.2.0
echo "${BLUE}${BOLD}    - Installing scipy!${NC}"
sudo /dorsa/env/bin/python -m pip install scipy
sudo /dorsa/env/bin/python -m pip install scipy
echo "${BLUE}${BOLD}    - Installing twilio!${NC}"
sudo /dorsa/env/bin/python -m pip install twilio        # needs sudo
echo "${BLUE}${BOLD}    - Installing pyaudio!${NC}"
sudo /dorsa/env/bin/python -m pip install pyaudio       # needs sudo

# Update Installation and remove old files
echo "${BLUE}${BOLD}   ---===   UPDATING DORSA   ===---   ${NC}"
/dorsa/env/bin/python -m pip install --upgrade /dorsa/tempDorsa
echo "${BLUE}${BOLD}    - Deleting temporary Files!${NC}"
sudo rm -R /dorsa/tempDorsa
sudo chmod 755 /home/pi/.ssh
sudo chmod 400 /home/pi/.ssh/config
sudo chmod 600 /home/pi/.ssh/id_rsa
sudo chmod 600 /dorsa/ssh-key

# Set Volume to 40%
sudo amixer sset 'Master' 40%

echo "${CYAN}${BOLD}Installation Complete..!!!${NC}"

