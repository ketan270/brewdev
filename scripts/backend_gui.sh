#!/bin/bash

show_main_menu() {
    dialog --clear --title "BrewDev Backend Menu" \
        --menu "Use arrow keys to navigate and Enter to select:" \
        15 50 3 \
        1 "Install Backend Components" \
        2 "Uninstall Backend Components" \
        3 "Exit" 2>/tmp/backend_main_choice
}

show_install_menu() {
    dialog --clear --title "Install Backend Components" \
        --checklist "Select components to install:" \
        20 60 12 \
        1 "Node.js" OFF \
        2 "Python" OFF \
        3 "Go (Golang)" OFF \
        4 "Java (OpenJDK)" OFF \
        5 "PostgreSQL" OFF \
        6 "MySQL" OFF \
        7 "MongoDB" OFF \
        8 "SQLite" OFF \
        9 "Docker" OFF \
        10 "Redis" OFF \
        11 "Development Tools" OFF 2>/tmp/backend_install_choices
}

show_uninstall_menu() {
    dialog --clear --title "Uninstall Backend Components" \
        --checklist "Select components to uninstall:" \
        20 60 12 \
        1 "Node.js" OFF \
        2 "Python" OFF \
        3 "Go (Golang)" OFF \
        4 "Java (OpenJDK)" OFF \
        5 "PostgreSQL" OFF \
        6 "MySQL" OFF \
        7 "MongoDB" OFF \
        8 "SQLite" OFF \
        9 "Docker" OFF \
        10 "Redis" OFF \
        11 "Development Tools" OFF 2>/tmp/backend_uninstall_choices
}

install_nodejs() {
    dialog --infobox "Installing Node.js..." 5 40
    bash "$(dirname "$0")/install/install_node.sh" >/dev/null 2>&1
    npm install -g express-generator nodemon pm2 >/dev/null 2>&1
    if command -v node &>/dev/null; then
        dialog --msgbox "Node.js has been installed!" 5 40
    else
        dialog --msgbox "Node.js installation failed." 5 40
    fi
}

install_python() {
    dialog --infobox "Installing Python..." 5 40
    bash "$(dirname "$0")/install/install_python.sh" >/dev/null 2>&1
    pip3 install flask django gunicorn >/dev/null 2>&1
    if command -v python3 &>/dev/null; then
        dialog --msgbox "Python has been installed!" 5 40
    else
        dialog --msgbox "Python installation failed." 5 40
    fi
}

install_go() {
    dialog --infobox "Installing Go..." 5 40
    bash "$(dirname "$0")/install/install_go.sh" >/dev/null 2>&1
    if command -v go &>/dev/null; then
        dialog --msgbox "Go has been installed!" 5 40
    else
        dialog --msgbox "Go installation failed." 5 40
    fi
}

install_java() {
    dialog --infobox "Installing Java..." 5 40
    bash "$(dirname "$0")/install/install_java.sh" >/dev/null 2>&1
    if command -v java &>/dev/null; then
        dialog --msgbox "Java has been installed!" 5 40
    else
        dialog --msgbox "Java installation failed." 5 40
    fi
}

install_postgresql() {
    dialog --infobox "Installing PostgreSQL..." 5 40
    bash "$(dirname "$0")/install/install_postgres.sh" >/dev/null 2>&1
    if command -v psql &>/dev/null; then
        dialog --msgbox "PostgreSQL has been installed!" 5 40
    else
        dialog --msgbox "PostgreSQL installation failed." 5 40
    fi
}

install_mysql() {
    dialog --infobox "Installing MySQL..." 5 40
    bash "$(dirname "$0")/install/install_mysql.sh" >/dev/null 2>&1
    if command -v mysql &>/dev/null; then
        dialog --msgbox "MySQL has been installed!" 5 40
    else
        dialog --msgbox "MySQL installation failed." 5 40
    fi
}

install_mongodb() {
    dialog --infobox "Installing MongoDB..." 5 40
    bash "$(dirname "$0")/install/install_mongodb.sh" >/dev/null 2>&1
    if systemctl is-active --quiet mongod; then
        dialog --msgbox "MongoDB has been installed!" 5 40
    else
        dialog --msgbox "MongoDB installation failed." 5 40
    fi
}

install_sqlite() {
    dialog --infobox "Installing SQLite..." 5 40
    bash "$(dirname "$0")/install/install_sqlite.sh" >/dev/null 2>&1
    if command -v sqlite3 &>/dev/null; then
        dialog --msgbox "SQLite has been installed!" 5 40
    else
        dialog --msgbox "SQLite installation failed." 5 40
    fi
}

install_docker() {
    dialog --infobox "Installing Docker..." 5 40
    bash "$(dirname "$0")/install/install_docker.sh" >/dev/null 2>&1
    bash "$(dirname "$0")/install/install_docker_hub.sh" >/dev/null 2>&1
    if command -v docker &>/dev/null; then
        dialog --msgbox "Docker has been installed!" 5 40
    else
        dialog --msgbox "Docker installation failed." 5 40
    fi
}

install_redis() {
    dialog --infobox "Installing Redis..." 5 40
    bash "$(dirname "$0")/install/install_redis.sh" >/dev/null 2>&1
    if systemctl is-active --quiet redis-server; then
        dialog --msgbox "Redis has been installed!" 5 40
    else
        dialog --msgbox "Redis installation failed." 5 40
    fi
}

install_dev_tools() {
    dialog --infobox "Installing development tools..." 5 40
    sudo apt update >/dev/null 2>&1
    sudo apt install -y git curl wget jq build-essential >/dev/null 2>&1
    if command -v git &>/dev/null; then
        dialog --msgbox "Development tools have been installed!" 5 40
    else
        dialog --msgbox "Development tools installation failed." 5 40
    fi
}

uninstall_nodejs() {
    dialog --infobox "Uninstalling Node.js..." 5 40
    sudo apt purge -y nodejs npm >/dev/null 2>&1
    sudo rm -rf /usr/local/lib/node_modules >/dev/null 2>&1
    sudo rm -rf ~/.npm >/dev/null 2>&1
    if ! command -v node &>/dev/null; then
        dialog --msgbox "Node.js has been uninstalled!" 5 40
    else
        dialog --msgbox "Node.js uninstallation failed." 5 40
    fi
}

uninstall_python() {
    dialog --infobox "Uninstalling Python packages..." 5 40
    pip3 uninstall -y flask django gunicorn >/dev/null 2>&1
    dialog --msgbox "Python packages have been uninstalled!" 5 40
}

uninstall_go() {
    dialog --infobox "Uninstalling Go..." 5 40
    sudo apt purge -y golang-go >/dev/null 2>&1
    sudo rm -rf /usr/local/go >/dev/null 2>&1
    if ! command -v go &>/dev/null; then
        dialog --msgbox "Go has been uninstalled!" 5 40
    else
        dialog --msgbox "Go uninstallation failed." 5 40
    fi
}

uninstall_java() {
    dialog --infobox "Uninstalling Java..." 5 40
    sudo apt purge -y openjdk-*-jdk maven >/dev/null 2>&1
    if ! command -v java &>/dev/null; then
        dialog --msgbox "Java has been uninstalled!" 5 40
    else
        dialog --msgbox "Java uninstallation failed." 5 40
    fi
}

uninstall_postgresql() {
    dialog --infobox "Uninstalling PostgreSQL..." 5 40
    sudo apt purge -y postgresql postgresql-contrib >/dev/null 2>&1
    sudo rm -rf /var/lib/postgresql/ >/dev/null 2>&1
    if ! command -v psql &>/dev/null; then
        dialog --msgbox "PostgreSQL has been uninstalled!" 5 40
    else
        dialog --msgbox "PostgreSQL uninstallation failed." 5 40
    fi
}

uninstall_mysql() {
    dialog --infobox "Uninstalling MySQL..." 5 40
    sudo apt purge -y mysql-server mysql-client mysql-common >/dev/null 2>&1
    sudo rm -rf /var/lib/mysql/ >/dev/null 2>&1
    sudo rm -rf /etc/mysql/ >/dev/null 2>&1
    if ! command -v mysql &>/dev/null; then
        dialog --msgbox "MySQL has been uninstalled!" 5 40
    else
        dialog --msgbox "MySQL uninstallation failed." 5 40
    fi
}

uninstall_mongodb() {
    dialog --infobox "Uninstalling MongoDB..." 5 40
    sudo systemctl stop mongod >/dev/null 2>&1
    sudo apt purge -y mongodb-org* >/dev/null 2>&1
    sudo rm -rf /var/log/mongodb >/dev/null 2>&1
    sudo rm -rf /var/lib/mongodb >/dev/null 2>&1
    if ! systemctl is-active --quiet mongod; then
        dialog --msgbox "MongoDB has been uninstalled!" 5 40
    else
        dialog --msgbox "MongoDB uninstallation failed." 5 40
    fi
}

uninstall_sqlite() {
    dialog --infobox "Uninstalling SQLite..." 5 40
    sudo apt purge -y sqlite3 >/dev/null 2>&1
    if ! command -v sqlite3 &>/dev/null; then
        dialog --msgbox "SQLite has been uninstalled!" 5 40
    else
        dialog --msgbox "SQLite uninstallation failed." 5 40
    fi
}

uninstall_docker() {
    dialog --infobox "Uninstalling Docker..." 5 40
    sudo systemctl stop docker docker.socket containerd >/dev/null 2>&1
    sudo apt purge -y docker-ce docker-ce-cli containerd.io docker-compose-plugin docker.io >/dev/null 2>&1
    sudo rm -rf /var/lib/docker >/dev/null 2>&1
    sudo rm -rf /var/lib/containerd >/dev/null 2>&1
    if ! command -v docker &>/dev/null; then
        dialog --msgbox "Docker has been uninstalled!" 5 40
    else
        dialog --msgbox "Docker uninstallation failed." 5 40
    fi
}

uninstall_redis() {
    dialog --infobox "Uninstalling Redis..." 5 40
    sudo systemctl stop redis-server >/dev/null 2>&1
    sudo apt purge -y redis-server >/dev/null 2>&1
    if ! systemctl is-active --quiet redis-server; then
        dialog --msgbox "Redis has been uninstalled!" 5 40
    else
        dialog --msgbox "Redis uninstallation failed." 5 40
    fi
}

uninstall_dev_tools() {
    dialog --infobox "Uninstalling development tools..." 5 40
    sudo apt purge -y jq build-essential >/dev/null 2>&1
    dialog --msgbox "Development tools have been uninstalled! (git, curl, wget not removed for safety)" 5 60
}

process_installation() {
    choices=$(cat /tmp/backend_install_choices)
    if [ -z "$choices" ]; then
        dialog --msgbox "No components selected for installation." 5 40
        return
    fi
    for choice in $choices; do
        case $choice in
            1) install_nodejs ;;
            2) install_python ;;
            3) install_go ;;
            4) install_java ;;
            5) install_postgresql ;;
            6) install_mysql ;;
            7) install_mongodb ;;
            8) install_sqlite ;;
            9) install_docker ;;
            10) install_redis ;;
            11) install_dev_tools ;;
        esac
    done
    dialog --msgbox "Backend installation complete!" 8 40
}

process_uninstallation() {
    choices=$(cat /tmp/backend_uninstall_choices)
    if [ -z "$choices" ]; then
        dialog --msgbox "No components selected for uninstallation." 5 40
        return
    fi
    for choice in $choices; do
        case $choice in
            1) uninstall_nodejs ;;
            2) uninstall_python ;;
            3) uninstall_go ;;
            4) uninstall_java ;;
            5) uninstall_postgresql ;;
            6) uninstall_mysql ;;
            7) uninstall_mongodb ;;
            8) uninstall_sqlite ;;
            9) uninstall_docker ;;
            10) uninstall_redis ;;
            11) uninstall_dev_tools ;;
        esac
    done
    dialog --infobox "Cleaning up..." 5 40
    sudo apt autoremove -y >/dev/null 2>&1
    sudo apt clean >/dev/null 2>&1
    dialog --msgbox "Backend uninstallation complete!" 8 40
}

if ! command -v dialog &>/dev/null; then
    echo "Installing dialog package..."
    sudo apt update && sudo apt install -y dialog
fi

while true; do
    show_main_menu
    if [ ! -f "/tmp/backend_main_choice" ]; then
        clear
        echo "Dialog canceled or closed. Exiting..."
        exit 0
    fi
    main_menu_choice=$(cat /tmp/backend_main_choice)
    case $main_menu_choice in
        1)
            show_install_menu
            if [ $? -eq 0 ] && [ -f "/tmp/backend_install_choices" ]; then
                process_installation
            fi
            ;;
        2)
            show_uninstall_menu
            if [ $? -eq 0 ] && [ -f "/tmp/backend_uninstall_choices" ]; then
                process_uninstallation
            fi
            ;;
        3)
            clear
            exit 0
            ;;
        *)
            dialog --msgbox "Invalid choice, please try again." 5 30
            ;;
    esac
done
