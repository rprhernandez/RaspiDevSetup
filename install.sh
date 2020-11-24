#!/bin/bash
 
# Updated 2020-11-24

BASE_DIR=~/tempRaspiDevSetup

BLUE='\033[0;34m'
CYAN='\033[0;36m'
RED='\033[0;31m'
NC='\033[0m' # [n]o color

BOLD='\033[1m'

echo "${CYAN}${BOLD}Updating Raspberry pi${NC}"
echo "${CYAN}${BOLD}Please wait...!${NC}"

# Creating Directory for Dorsa
echo "${BLUE}${BOLD}Creating Directory for Installer!${NC}"
echo "${BLUE}${BOLD}    - mkdir $BASE_DIR!${NC}"
sudo mkdir $BASE_DIR
echo "${BLUE}${BOLD}    - chown $USER $BASE_DIR!${NC}"
sudo chown $USER $BASE_DIR

# Disable Screensaver
echo "${BLUE}${BOLD}Disabling Screensaver!${NC}"
sudo xset s off
sudo xset -dpms
sudo xset s noblank







