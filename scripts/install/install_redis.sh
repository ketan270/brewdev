#!/bin/bash

GREEN="\033[0;32m"
CYAN="\033[0;36m"
RED="\033[0;31m"
RESET="\033[0m"

echo -e "${CYAN}Installing Redis...${RESET}"
sudo apt update && sudo apt install -y redis-server

echo -e "${CYAN}Configuring and starting Redis...${RESET}"
sudo sed -i 's/supervised no/supervised systemd/g' /etc/redis/redis.conf
sudo systemctl restart redis-server
sudo systemctl enable redis-server

if systemctl is-active --quiet redis-server; then
  echo -e "${GREEN}Redis installed and running successfully!${RESET}"
else
  echo -e "${RED}Redis installation failed or service is not running.${RESET}"
fi