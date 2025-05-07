#!/bin/bash

GREEN="\033[0;32m"
CYAN="\033[0;36m"
RED="\033[0;31m"
RESET="\033[0m"

echo -e "${CYAN}Installing Java (OpenJDK)...${RESET}"
sudo apt update && sudo apt install -y openjdk-17-jdk maven

if command -v java &>/dev/null; then
  echo -e "${GREEN}Java installed successfully!${RESET}"
  java --version
else
  echo -e "${RED}Java installation failed.${RESET}"
fi