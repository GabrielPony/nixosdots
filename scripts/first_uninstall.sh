#!/usr/bin/env bash

# Define colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Default devices
DISK="/dev/sda"
SWAP_PART="/dev/sda3"

# Process command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        --disk)
            DISK="$2"
            shift 2
            ;;
        --swap)
            SWAP_PART="$2"
            shift 2
            ;;
        *)
            echo -e "${RED}Unknown parameter: $1${NC}"
            echo "Usage: $0 [--disk /dev/sdX] [--swap /dev/sdXY]"
            exit 1
            ;;
    esac
done

# Display devices to be used
echo -e "${YELLOW}Will use the following devices:${NC}"
echo -e "  Disk: ${GREEN}${DISK}${NC}"
echo -e "  Swap partition: ${GREEN}${SWAP_PART}${NC}"
echo

# Confirm operation
echo -e "${RED}WARNING: This operation will unmount all mount points and erase disk signatures!${NC}"
read -p "Are you sure you want to continue? (y/N): " confirm
if [[ "$confirm" != "y" && "$confirm" != "Y" ]]; then
    echo -e "${YELLOW}Operation cancelled${NC}"
    exit 0
fi

# Unmount filesystems
echo -e "${GREEN}Unmounting filesystems...${NC}"

# Check and unmount /mnt/boot
if mount | grep -q "/mnt/boot"; then
    echo -e "  ${YELLOW}Unmounting /mnt/boot${NC}"
    sudo umount /mnt/boot || { echo -e "${RED}Failed to unmount /mnt/boot${NC}"; }
else
    echo -e "  ${YELLOW}/mnt/boot not mounted${NC}"
fi

# Check and unmount /mnt/nix
if mount | grep -q "/mnt/nix"; then
    echo -e "  ${YELLOW}Unmounting /mnt/nix${NC}"
    sudo umount /mnt/nix || { echo -e "${RED}Failed to unmount /mnt/nix${NC}"; }
else
    echo -e "  ${YELLOW}/mnt/nix not mounted${NC}"
fi

# Check and unmount /mnt/home
if mount | grep -q "/mnt/home"; then
    echo -e "  ${YELLOW}Unmounting /mnt/home${NC}"
    sudo umount /mnt/home || { echo -e "${RED}Failed to unmount /mnt/home${NC}"; }
else
    echo -e "  ${YELLOW}/mnt/home not mounted${NC}"
fi

# Check and unmount /mnt
if mount | grep -q "on /mnt "; then
    echo -e "  ${YELLOW}Unmounting /mnt${NC}"
    sudo umount /mnt || { echo -e "${RED}Failed to unmount /mnt${NC}"; }
else
    echo -e "  ${YELLOW}/mnt not mounted${NC}"
fi

# Deactivate swap partition
echo -e "${GREEN}Deactivating swap partition...${NC}"
if swapon -s | grep -q "$SWAP_PART"; then
    echo -e "  ${YELLOW}Turning off swap partition $SWAP_PART${NC}"
    sudo swapoff "$SWAP_PART" 2>/dev/null || echo -e "${RED}Failed to deactivate swap partition $SWAP_PART or it doesn't exist${NC}"
else
    echo -e "  ${YELLOW}Swap partition $SWAP_PART not active${NC}"
fi

# Erase disk signatures
echo -e "${GREEN}Erasing disk signatures...${NC}"
echo -e "  ${YELLOW}Erasing all signatures on $DISK${NC}"
sudo wipefs -a "$DISK" || { echo -e "${RED}Failed to erase signatures on $DISK${NC}"; exit 1; }
echo -e "${GREEN}Disk signatures successfully erased!${NC}"

echo -e "${GREEN}All operations completed!${NC}"
