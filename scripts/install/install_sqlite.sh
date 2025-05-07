#!/bin/bash

GREEN="\033[0;32m"
CYAN="\033[0;36m"
RED="\033[0;31m"
RESET="\033[0m"

echo -e "${CYAN}Installing SQLite...${RESET}"
sudo apt update && sudo apt install -y sqlite3

if command -v sqlite3 &>/dev/null; then
  echo -e "${GREEN}SQLite installed successfully!${RESET}"
  sqlite3 --version
else
  echo -e "${RED}SQLite installation failed.${RESET}"
fi