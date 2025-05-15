#!/usr/bin/env bash

# Define colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Default configuration
DEFAULT_GATEWAY="192.168.7.3"
DEFAULT_INTERFACE="ens18"

# Display help information
show_help() {
    echo -e "${BLUE}Change Default Gateway Script${NC}"
    echo "Usage: $0 [options]"
    echo
    echo "Options:"
    echo "  -g, --gateway GATEWAY    Set default gateway IP (default: ${DEFAULT_GATEWAY})"
    echo "  -i, --interface IFACE    Set network interface (default: ${DEFAULT_INTERFACE})"
    echo "  -h, --help               Display this help information"
    echo
    echo "Examples:"
    echo "  $0                       # Use default configuration"
    echo "  $0 -g 10.0.0.1           # Use custom gateway"
    echo "  $0 -i eth0 -g 10.0.0.1   # Use custom interface and gateway"
}

# Parse command line arguments
GATEWAY="${DEFAULT_GATEWAY}"
INTERFACE="${DEFAULT_INTERFACE}"

while [[ $# -gt 0 ]]; do
    case $1 in
        -g|--gateway)
            GATEWAY="$2"
            shift 2
            ;;
        -i|--interface)
            INTERFACE="$2"
            shift 2
            ;;
        -h|--help)
            show_help
            exit 0
            ;;
        *)
            echo -e "${RED}Error: Unknown parameter $1${NC}" >&2
            show_help
            exit 1
            ;;
    esac
done

# Check for root privileges
if [ "$(id -u)" -ne 0 ]; then
    echo -e "${RED}Error: This script requires root privileges${NC}" >&2
    echo "Please run this script with sudo"
    exit 1
fi

# Display current configuration
echo -e "${BLUE}Current network configuration:${NC}"
echo -e "$(ip route | grep default || echo -e "${YELLOW}No default route found${NC}")"
echo

# Check if network interface exists
if ! ip link show "${INTERFACE}" &>/dev/null; then
    echo -e "${RED}Error: Network interface ${INTERFACE} does not exist${NC}" >&2
    echo -e "Available network interfaces:"
    ip -o link show | awk -F': ' '{print "  " $2}'
    exit 1
fi

# Check if network interface is enabled
if [[ "$(ip -o link show "${INTERFACE}" | awk '{print $9}')" != "UP" ]]; then
    echo -e "${YELLOW}Warning: Network interface ${INTERFACE} appears to be disabled${NC}" >&2
    echo -e "Attempting to enable interface..."
    ip link set "${INTERFACE}" up
    if [[ $? -ne 0 ]]; then
        echo -e "${RED}Error: Unable to enable network interface ${INTERFACE}${NC}" >&2
        exit 1
    fi
fi

# Delete current default route
echo -e "${YELLOW}Deleting current default route...${NC}"
ip route del default
if [[ $? -ne 0 ]]; then
    echo -e "${YELLOW}Note: No default route found or unable to delete${NC}"
fi

# Add new default route
echo -e "${YELLOW}Adding new default route...${NC}"
echo -e "  Gateway: ${GREEN}${GATEWAY}${NC}"
echo -e "  Interface: ${GREEN}${INTERFACE}${NC}"

ip route add default via "${GATEWAY}" dev "${INTERFACE}"
if [[ $? -ne 0 ]]; then
    echo -e "${RED}Error: Unable to add default route${NC}" >&2
    exit 1
fi

# Verify new route
echo -e "${GREEN}Successfully changed default route!${NC}"
echo -e "${BLUE}New network configuration:${NC}"
ip route | grep default

# Test connection
echo -e "\n${YELLOW}Testing network connection...${NC}"
if ping -c 1 -W 2 8.8.8.8 &>/dev/null; then
    echo -e "${GREEN}Network connection is working!${NC}"
else
    echo -e "${RED}Warning: Unable to connect to the internet, please check network configuration${NC}" >&2
fi
