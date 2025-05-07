#!/bin/bash
COMMAND=$1
SUBCOMMAND=$2
VERSION="0.0.1"

case "$COMMAND" in
  --help|-h)
    echo "Usage: brewdev [command] [subcommand]"
    echo
    echo "Commands:"
    echo "  setup fullstack     Install fullstack environment"
    echo "  setup frontend      Install frontend-only tools"
    echo "  setup backend       Install backend stack"
    echo
    echo "Options:"
    echo "  --help, -h          Show this help message"
    echo "  --version, -v       Show brewdev version"
    exit 0
    ;;
  --version|-v)
    echo "🍺 brewdev version $VERSION"
    exit 0
    ;;
esac

RED="\033[0;31m"
GREEN="\033[0;32m"
RESET="\033[0m"

if [[ "$COMMAND" == "setup" ]]; then
  if [[ "$SUBCOMMAND" == "fullstack" ]]; then
    if [[ "$3" == "--gui" ]]; then
      bash scripts/gui.sh
    else
      bash scripts/setup_fullstack.sh
    fi
  elif [[ "$SUBCOMMAND" == "backend" ]]; then
    if [[ "$3" == "--gui" ]]; then
      bash scripts/backend_gui.sh
    else
      bash scripts/setup_backend.sh
    fi
  else
    echo -e "${RED}Unknown setup type: $SUBCOMMAND${RESET}"
    echo "Available setup types: fullstack, backend"
    echo "Use --gui flag for graphical interface (e.g., brewdev setup backend --gui)"
  fi
elif [[ "$COMMAND" == "uninstall" ]]; then
  if [[ "$SUBCOMMAND" == "fullstack" ]]; then
    if [[ "$3" == "--gui" ]]; then
      bash scripts/gui.sh
    else
      bash scripts/uninstall_fullstack.sh
    fi
  elif [[ "$SUBCOMMAND" == "backend" ]]; then
    if [[ "$3" == "--gui" ]]; then
      bash scripts/backend_gui.sh
    else
      bash scripts/uninstall_backend.sh
    fi
  else
    echo -e "${RED}Unknown uninstall type: $SUBCOMMAND${RESET}"
    echo "Available uninstall types: fullstack, backend"
    echo "Use --gui flag for graphical interface (e.g., brewdev uninstall backend --gui)"
  fi
else
  echo -e "${RED}Unknown command: $COMMAND${RESET}"
  echo -e "${GREEN}Use 'brewdev --help' for usage information${RESET}"
fi
