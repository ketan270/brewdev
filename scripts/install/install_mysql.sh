#!/bin/bash

GREEN="\033[0;32m"
CYAN="\033[0;36m"
RED="\033[0;31m"
RESET="\033[0m"

echo -e "${CYAN}Installing MySQL...${RESET}"
sudo apt update && sudo apt install -y mysql-server

echo -e "${CYAN}Starting MySQL service...${RESET}"
sudo systemctl start mysql
sudo systemctl enable mysql

if command -v mysql &>/dev/null; then
  echo -e "${GREEN}MySQL installed successfully!${RESET}"
else
  echo -e "${RED}MySQL installation failed.${RESET}"
fi