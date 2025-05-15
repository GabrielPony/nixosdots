#!/bin/bash
set -e  # Stop on error

# Color definitions
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[0;33m'
NC='\033[0m'  # No Color

# Default values
DISK=""
HOSTNAME=""
BOOT_MODE="uefi"  # Default boot mode is UEFI

# Parse command line arguments
while getopts "h:d:b:" opt; do
  case $opt in
    h) HOSTNAME="$OPTARG" ;;
    d) DISK="$OPTARG" ;;
    b) BOOT_MODE=$(echo "$OPTARG" | tr '[:upper:]' '[:lower:]') ;;
    \?) echo "Invalid option: -$OPTARG" >&2; exit 1 ;;
  esac
done

# Check if required parameters are provided
if [ -z "$HOSTNAME" ] || [ -z "$DISK" ]; then
  echo -e "${RED}Error: Missing required parameters${NC}"
  echo -e "Usage: $0 -h hostname -d disk_device [-b boot_mode]"
  echo -e "Example: $0 -h myhost -d /dev/sda -b uefi|legacy"
  exit 1
fi

# Validate boot mode
if [ "$BOOT_MODE" != "uefi" ] && [ "$BOOT_MODE" != "legacy" ]; then
  echo -e "${RED}Error: Boot mode must be 'uefi' or 'legacy'${NC}"
  exit 1
fi

echo -e "${YELLOW}=== Starting NixOS automated installation ===${NC}"
echo -e "${RED}Target device: $DISK${NC}"
echo -e "${YELLOW}Hostname: $HOSTNAME${NC}"
echo -e "${YELLOW}Boot mode: ${BOOT_MODE}${NC}"
echo -e "${RED}WARNING: This will erase ALL data on $DISK!${NC}"
echo -e "${YELLOW}Starting in 5 seconds, press Ctrl+C to cancel...${NC}"
sleep 5

# 1. Partitioning
echo -e "${GREEN}=== Creating partitions ===${NC}"
parted -s $DISK -- mklabel gpt

if [ "$BOOT_MODE" = "uefi" ]; then
  # UEFI partitioning
  parted -s $DISK -- mkpart ESP fat32 1MiB 256MiB
  parted -s $DISK -- set 1 esp on
  parted -s $DISK -- mkpart primary 256MiB -8GiB
  parted -s $DISK -- mkpart primary linux-swap -8GiB 100%

  # 2. Formatting partitions
  echo -e "${GREEN}=== Formatting partitions ===${NC}"
  mkfs.fat -F 32 ${DISK}1
  mkfs.btrfs -f -L nixos ${DISK}2
  mkswap -L swap ${DISK}3

  # 3. Creating btrfs subvolumes
  echo -e "${GREEN}=== Creating btrfs subvolumes ===${NC}"
  mount ${DISK}2 /mnt
  btrfs subvolume create /mnt/root
  btrfs subvolume create /mnt/home
  btrfs subvolume create /mnt/nix
  umount /mnt

  # 4. Mounting filesystems
  echo -e "${GREEN}=== Mounting filesystems ===${NC}"
  mount -o compress=zstd,subvol=root ${DISK}2 /mnt
  mkdir -p /mnt/{home,nix,boot}
  mount -o compress=zstd,subvol=home ${DISK}2 /mnt/home
  mount -o compress=zstd,noatime,subvol=nix ${DISK}2 /mnt/nix
  mount ${DISK}1 /mnt/boot
  swapon ${DISK}3
else
  # BIOS/Legacy partitioning
  parted -s $DISK -- mkpart BIOSBOOT 1MiB 3MiB
  parted -s $DISK -- set 1 bios_grub on
  parted -s $DISK -- mkpart primary 3MiB -8GiB
  parted -s $DISK -- mkpart primary linux-swap -8GiB 100%

  # 2. Formatting partitions
  echo -e "${GREEN}=== Formatting partitions ===${NC}"
  # BIOS boot partition doesn't need formatting
  mkfs.btrfs -f -L nixos ${DISK}2
  mkswap -L swap ${DISK}3

  # 3. Creating btrfs subvolumes
  echo -e "${GREEN}=== Creating btrfs subvolumes ===${NC}"
  mount ${DISK}2 /mnt
  btrfs subvolume create /mnt/root
  btrfs subvolume create /mnt/home
  btrfs subvolume create /mnt/nix
  umount /mnt

  # 4. Mounting filesystems
  echo -e "${GREEN}=== Mounting filesystems ===${NC}"
  mount -o compress=zstd,subvol=root ${DISK}2 /mnt
  mkdir -p /mnt/{home,nix}
  mount -o compress=zstd,subvol=home ${DISK}2 /mnt/home
  mount -o compress=zstd,noatime,subvol=nix ${DISK}2 /mnt/nix
  swapon ${DISK}3
fi

echo -e "${GREEN}=== Partitioning and mounting complete ===${NC}"
lsblk $DISK

# 5. Cloning NixOS configuration
echo -e "${GREEN}=== Cloning NixOS configuration ===${NC}"
mkdir -p /mnt/etc
git clone https://github.com/GabrielPony/nixosdots.git /mnt/etc/nixos/nixosdots

# Create a file to indicate boot mode for future reference
echo "$BOOT_MODE" > /mnt/etc/nixos/boot_mode

# 6. Installing NixOS
echo -e "${GREEN}=== Starting NixOS installation ===${NC}"
nixos-install --root /mnt --flake /mnt/etc/nixos/nixosdots#$HOSTNAME --no-root-passwd

echo -e "${GREEN}=== Installation complete ===${NC}"
echo -e "${YELLOW}Please set root password:${NC}"
nixos-enter --root /mnt -c 'passwd'

echo -e "${GREEN}=== All operations completed, you can reboot now ===${NC}"
