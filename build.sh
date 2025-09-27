#!/bin/bash

# Build script for ROS2 Jazzy development environment
# This script uses Packer to automatically build a custom Ubuntu Noble box with ROS2 Jazzy
# No manual intervention required - the build process is fully automated

set -e

echo "Building ROS2 Jazzy development environment..."

# Check if required tools are installed
if ! command -v packer &> /dev/null; then
    echo "Error: Packer is not installed. Please install Packer first."
    exit 1
fi

if ! command -v vagrant &> /dev/null; then
    echo "Error: Vagrant is not installed. Please install Vagrant first."
    exit 1
fi

# Check if VMware Fusion provider is installed
if ! vagrant plugin list | grep -q "vagrant-vmware-desktop"; then
    echo "Error: VMware Fusion provider is not installed."
    echo "Please install it with: vagrant plugin install vagrant-vmware-desktop"
    exit 1
fi

# Set up ISO URL and checksum for Ubuntu Noble 24.04 LTS ARM64
# You can download the ISO from: https://cdimage.ubuntu.com/releases/24.04/release/
# and calculate the SHA256 checksum

if [ -z "$ISO_URL" ]; then
    echo "Setting default ISO URL for Ubuntu Noble 24.04 LTS ARM64..."
    export ISO_URL="https://cdimage.ubuntu.com/releases/24.04/release/ubuntu-24.04.1-server-arm64.iso"
fi

if [ -z "$ISO_CHECKSUM" ]; then
    echo "Setting default ISO checksum for Ubuntu Noble 24.04 LTS ARM64..."
    # This is the SHA256 checksum for ubuntu-24.04.1-server-arm64.iso
    # You should verify this matches your downloaded ISO
    export ISO_CHECKSUM="a4acfda10b18da50e2ec50ccaf526d6bc321d9774dda443996819ae424fe8f20"
fi

echo "Using ISO URL: $ISO_URL"
echo "Using ISO checksum: $ISO_CHECKSUM"

# Build the box with Packer
echo "Building custom ROS2 Jazzy box..."
packer build packer.json

echo "Build completed! You can now use the box with:"
echo "  vagrant box add ros2-jazzy ros2-jazzy-arm64-vmware.box"
echo "  vagrant up"
