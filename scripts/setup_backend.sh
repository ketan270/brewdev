#!/bin/bash

CYAN="\033[0;36m"
GREEN="\033[0;32m"
RED="\033[0;31m"
YELLOW="\033[0;33m"
RESET="\033[0m"

echo -e "${CYAN}Backend setup selected.${RESET}"
echo

echo -e "${YELLOW}Choose your backend language:${RESET}"
select lang in "JavaScript/Node.js" "Python" "Go" "Java"; do
  case $lang in
    "JavaScript/Node.js")
      echo -e "${GREEN}You selected Node.js${RESET}"
      bash "$(dirname "$0")/install/install_node.sh"
      echo -e "${CYAN}Installing Express and common backend packages...${RESET}"
      npm install -g express-generator nodemon pm2
      echo -e "${GREEN}✓ Installed Express and tools${RESET}"
      break
      ;;
    "Python")
      echo -e "${GREEN}You selected Python${RESET}"
      bash "$(dirname "$0")/install/install_python.sh"
      echo -e "${CYAN}Installing Flask, Django and common backend packages...${RESET}"
      pip3 install flask django gunicorn
      echo -e "${GREEN}✓ Installed Python web frameworks${RESET}"
      break
      ;;
    "Go")
      echo -e "${GREEN}You selected Go${RESET}"
      bash "$(dirname "$0")/install/install_go.sh"
      echo -e "${CYAN}Installing common Go backend tools...${RESET}"
      go install github.com/gin-gonic/gin@latest
      echo -e "${GREEN}✓ Installed Go tools${RESET}"
      break
      ;;
    "Java")
      echo -e "${GREEN}You selected Java${RESET}"
      sudo apt update && sudo apt install -y openjdk-17-jdk maven
      echo -e "${GREEN}✓ Installed Java and Maven${RESET}"
      break
      ;;
    *)
      echo -e "${RED}Invalid option. Try again.${RESET}"
      ;;
  esac
done

echo
echo -e "${YELLOW}Choose your database:${RESET}"
select db in "PostgreSQL" "MySQL" "MongoDB" "SQLite" "Skip database"; do
  case $db in
    "PostgreSQL")
      echo -e "${GREEN}Setting up PostgreSQL...${RESET}"
      bash "$(dirname "$0")/install/install_postgres.sh"
      break
      ;;
    "MySQL")
      echo -e "${GREEN}Setting up MySQL...${RESET}"
      sudo apt update && sudo apt install -y mysql-server
      sudo systemctl start mysql
      sudo systemctl enable mysql
      echo -e "${GREEN}✓ MySQL installed${RESET}"
      break
      ;;
    "MongoDB")
      echo -e "${GREEN}Setting up MongoDB...${RESET}"
      wget -qO - https://www.mongodb.org/static/pgp/server-6.0.asc | sudo apt-key add -
      echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu $(lsb_release -cs)/mongodb-org/6.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-6.0.list
      sudo apt update
      sudo apt install -y mongodb-org
      sudo systemctl start mongod
      sudo systemctl enable mongod
      echo -e "${GREEN}✓ MongoDB installed${RESET}"
      break
      ;;
    "SQLite")
      echo -e "${GREEN}Setting up SQLite...${RESET}"
      sudo apt update && sudo apt install -y sqlite3
      echo -e "${GREEN}✓ SQLite installed${RESET}"
      break
      ;;
    "Skip database")
      echo -e "${YELLOW}Skipping database installation${RESET}"
      break
      ;;
    *)
      echo -e "${RED}Invalid option. Try again.${RESET}"
      ;;
  esac
done

echo
echo -e "${YELLOW}Do you want to install Docker?${RESET}"
select docker in "Yes" "No"; do
  case $docker in
    "Yes")
      echo -e "${GREEN}Installing Docker...${RESET}"
      bash "$(dirname "$0")/install/install_docker.sh"
      bash "$(dirname "$0")/install/install_docker_hub.sh"
      break
      ;;
    "No")
      echo -e "${YELLOW}Skipping Docker installation${RESET}"
      break
      ;;
    *)
      echo -e "${RED}Invalid option. Try again.${RESET}"
      ;;
  esac
done

echo
echo -e "${YELLOW}Do you want to install additional backend tools?${RESET}"
select tools in "Yes" "No"; do
  case $tools in
    "Yes")
      echo -e "${CYAN}Installing Git, Redis, and other useful tools...${RESET}"
      sudo apt update && sudo apt install -y git redis-server jq curl wget
      sudo systemctl start redis-server
      sudo systemctl enable redis-server
      echo -e "${GREEN}✓ Additional tools installed${RESET}"
      break
      ;;
    "No")
      echo -e "${YELLOW}Skipping additional tools${RESET}"
      break
      ;;
    *)
      echo -e "${RED}Invalid option. Try again.${RESET}"
      ;;
  esac
done

echo
echo -e "${GREEN}============================================${RESET}"
echo -e "${GREEN}✅ Backend environment setup complete!${RESET}"
echo -e "${GREEN}============================================${RESET}"
