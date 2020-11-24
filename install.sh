#!/bin/bash
 
# Updated 2020-11-24

BLUE='\033[0;34m'
CYAN='\033[0;36m'
RED='\033[0;31m'
NC='\033[0m' # [n]o color

BOLD='\033[1m'

echo "${CYAN}${BOLD}Updating Raspberry pi${NC}"
echo "${CYAN}${BOLD}Please wait...!${NC}"

# Disable Screensaver
echo "${BLUE}${BOLD}Disabling Screensaver!${NC}"
sudo xset s off
sudo xset -dpms
sudo xset s noblank







