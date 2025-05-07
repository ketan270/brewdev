#!/bin/bash

CYAN="\033[0;36m"
GREEN="\033[0;32m"
RED="\033[0;31m"
YELLOW="\033[0;33m"
RESET="\033[0m"

echo -e "${CYAN}Backend uninstallation selected.${RESET}"
echo

uninstalled_items=()

add_to_uninstalled() {
  uninstalled_items+=("$1")
}

echo -e "${YELLOW}Select programming languages to uninstall:${RESET}"
echo -e "(Press Enter after each selection, type 'done' when finished)"

languages=()
while true; do
  select lang in "Node.js" "Python" "Go" "Java" "done"; do
    if [[ "$lang" == "done" ]]; then
      break 2
    elif [[ "$lang" == "Node.js" ]]; then
      echo -e "${RED}Uninstalling Node.js...${RESET}"
      sudo apt purge -y nodejs npm
      sudo rm -rf /usr/local/lib/node_modules
      sudo rm -rf ~/.npm
      add_to_uninstalled "Node.js"
      break
    elif [[ "$lang" == "Python" ]]; then
      echo -e "${RED}Uninstalling Python packages...${RESET}"
      pip3 uninstall -y flask django gunicorn
      add_to_uninstalled "Python packages"
      break
    elif [[ "$lang" == "Go" ]]; then
      echo -e "${RED}Uninstalling Go...${RESET}"
      sudo apt purge -y golang-go
      sudo rm -rf /usr/local/go
      add_to_uninstalled "Go"
      break
    elif [[ "$lang" == "Java" ]]; then
      echo -e "${RED}Uninstalling Java...${RESET}"
      sudo apt purge -y openjdk-*-jdk maven
      add_to_uninstalled "Java"
      break
    else
      echo -e "${RED}Invalid option. Try again.${RESET}"
    fi
  done
done

echo
echo -e "${YELLOW}Select databases to uninstall:${RESET}"
echo -e "(Press Enter after each selection, type 'done' when finished)"

databases=()
while true; do
  select db in "PostgreSQL" "MySQL" "MongoDB" "SQLite" "done"; do
    if [[ "$db" == "done" ]]; then
      break 2
    elif [[ "$db" == "PostgreSQL" ]]; then
      echo -e "${RED}Uninstalling PostgreSQL...${RESET}"
      sudo apt purge -y postgresql postgresql-contrib
      sudo rm -rf /var/lib/postgresql/
      add_to_uninstalled "PostgreSQL"
      break
    elif [[ "$db" == "MySQL" ]]; then
      echo -e "${RED}Uninstalling MySQL...${RESET}"
      sudo apt purge -y mysql-server mysql-client mysql-common
      sudo rm -rf /var/lib/mysql/
      sudo rm -rf /etc/mysql/
      add_to_uninstalled "MySQL"
      break
    elif [[ "$db" == "MongoDB" ]]; then
      echo -e "${RED}Uninstalling MongoDB...${RESET}"
      sudo systemctl stop mongod
      sudo apt purge -y mongodb-org*
      sudo rm -rf /var/log/mongodb
      sudo rm -rf /var/lib/mongodb
      add_to_uninstalled "MongoDB"
      break
    elif [[ "$db" == "SQLite" ]]; then
      echo -e "${RED}Uninstalling SQLite...${RESET}"
      sudo apt purge -y sqlite3
      add_to_uninstalled "SQLite"
      break
    else
      echo -e "${RED}Invalid option. Try again.${RESET}"
    fi
  done
done

echo
echo -e "${YELLOW}Do you want to uninstall Docker?${RESET}"
select docker in "Yes" "No"; do
  case $docker in
    "Yes")
      echo -e "${RED}Uninstalling Docker...${RESET}"
      sudo systemctl stop docker docker.socket containerd
      sudo apt purge -y docker-ce docker-ce-cli containerd.io docker-compose-plugin docker.io
      sudo rm -rf /var/lib/docker
      sudo rm -rf /var/lib/containerd
      add_to_uninstalled "Docker"
      break
      ;;
    "No")
      echo -e "${YELLOW}Skipping Docker uninstallation${RESET}"
      break
      ;;
    *)
      echo -e "${RED}Invalid option. Try again.${RESET}"
      ;;
  esac
done

echo
echo -e "${YELLOW}Do you want to uninstall Redis and other backend tools?${RESET}"
select tools in "Yes" "No"; do
  case $tools in
    "Yes")
      echo -e "${RED}Uninstalling Redis and other tools...${RESET}"
      sudo systemctl stop redis-server
      sudo apt purge -y redis-server jq
      add_to_uninstalled "Redis and additional tools"
      break
      ;;
    "No")
      echo -e "${YELLOW}Skipping additional tools uninstallation${RESET}"
      break
      ;;
    *)
      echo -e "${RED}Invalid option. Try again.${RESET}"
      ;;
  esac
done

echo
echo -e "${CYAN}Cleaning up...${RESET}"
sudo apt autoremove -y
sudo apt clean

# Summary
echo
echo -e "${GREEN}============================================${RESET}"
echo -e "${GREEN}✅ Backend environment uninstallation complete!${RESET}"
echo -e "${GREEN}============================================${RESET}"
echo

if [ ${#uninstalled_items[@]} -gt 0 ]; then
  echo -e "${YELLOW}The following components were uninstalled:${RESET}"
  for item in "${uninstalled_items[@]}"; do
    echo -e " - $item"
  done
else
  echo -e "${YELLOW}No components were uninstalled.${RESET}"
fi
