#!/bin/bash

# Build script for ROS2 Jazzy development environment
# This script uses Packer to build a custom Ubuntu Noble box with ROS2 Jazzy

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

# Create a base Ubuntu Noble VM first (this needs to be done manually)
# You can download Ubuntu Noble 24.04 LTS and create a VM with VMware Fusion
# Then export it and set the SOURCE_VMX environment variable

if [ -z "$SOURCE_VMX" ]; then
    echo "Error: SOURCE_VMX environment variable is not set."
    echo "Please set it to the path of your Ubuntu Noble 24.04 VMX file."
    echo "Example: export SOURCE_VMX=/path/to/ubuntu-noble.vmx"
    exit 1
fi

if [ ! -f "$SOURCE_VMX" ]; then
    echo "Error: SOURCE_VMX file does not exist: $SOURCE_VMX"
    exit 1
fi

echo "Using source VMX: $SOURCE_VMX"

# Build the box with Packer
echo "Building custom ROS2 Jazzy box..."
packer build packer.json

echo "Build completed! You can now use the box with:"
echo "  vagrant box add ros2-jazzy ros2-jazzy-arm64-vmware.box"
echo "  vagrant up"
