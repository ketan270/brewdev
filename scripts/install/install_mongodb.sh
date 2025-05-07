#!/bin/bash

GREEN="\033[0;32m"
CYAN="\033[0;36m"
RED="\033[0;31m"
RESET="\033[0m"

echo -e "${CYAN}Installing MongoDB...${RESET}"

echo -e "${CYAN}Importing MongoDB public key...${RESET}"
wget -qO - https://www.mongodb.org/static/pgp/server-6.0.asc | sudo apt-key add -

echo -e "${CYAN}Setting up MongoDB repository...${RESET}"
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu $(lsb_release -cs)/mongodb-org/6.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-6.0.list

sudo apt update

echo -e "${CYAN}Installing MongoDB packages...${RESET}"
sudo apt install -y mongodb-org

echo -e "${CYAN}Starting MongoDB service...${RESET}"
sudo systemctl start mongod
sudo systemctl enable mongod

if systemctl is-active --quiet mongod; then
  echo -e "${GREEN}MongoDB installed and running successfully!${RESET}"
else
  echo -e "${RED}MongoDB installation failed or service is not running.${RESET}"
fi
