# ROS2 Development Environment for M Series Mac

This repository contains a Vagrant-based development environment for working with ROS2 on an M Series Mac using VMware Fusion.

## Overview

This project provides a virtualized ROS2 development environment that runs on Apple Silicon (M Series) Macs using VMware Fusion. This setup allows you to develop and test ROS2 applications in a Linux environment while using Mac.

## Prerequisites

- Apple Silicon Mac (M1, M2, M3, M4, etc.) - **ARM64 architecture required**
- VMware Fusion (latest version recommended) - **ARM64 version for M Series Macs**
- Vagrant (latest version recommended)
  - [Vagrant Documentation](https://www.vagrantup.com/docs)
  - VMware Fusion provider for Vagrant
    - [Vagrant VMware Provider Documentation](https://www.vagrantup.com/docs/providers/vmware)
    - [VMware Fusion Provider Plugin](https://github.com/hashicorp/vagrant-vmware-desktop)
- Sufficient disk space for the virtual machine
- At least 8GB RAM (16GB recommended)

## Features

- Pre-configured Ubuntu Linux virtual machine
- ROS2 Jazzy installation and setup
- Foxglove ROS bridge for visualization (auto-launches on startup)
- Development tools and dependencies
- Network configuration for ROS2 communication
- Port forwarding for Foxglove bridge (port 8765)
- Shared folder setup for code development

## Quick Start

### Install Required Tools
```
brew tap hashicorp/tap
brew install hashicorp/tap/hashicorp-vagrant
vagrant plugin install vagrant-vmware-desktop
```

1. Clone this repository
2. Install Vagrant and VMware Fusion and Vagrant VMware Utility https://www.vagrantup.com/downloads/vmware 
3. Run `vagrant up` to create and provision the virtual machine
4. Run `vagrant ssh` to access the ROS2 development environment
5. The Foxglove bridge will automatically start on port 8765
6. Connect to Foxglove Studio at `ws://localhost:8765` to visualize your ROS2 data
7. Start developing with ROS2!

## How It Works

This project uses Vagrant to automatically provision an Ubuntu 24.04 LTS ARM64 virtual machine with ROS2 Jazzy pre-installed. The provisioning happens automatically when you run `vagrant up`, so no manual setup is required.

## Project Structure

```
├── README.md           # This file
├── .gitignore         # Git ignore rules
├── LICENSE            # MIT License
└── Vagrantfile        # Vagrant configuration with ROS2 provisioning
```

## ROS2 Version

This project uses ROS2 Jazzy Jalisco, the latest LTS version, running on Ubuntu 22.04 LTS (Jammy). The configuration follows the [official ROS2 Jazzy installation documentation](https://docs.ros.org/en/jazzy/Installation/Ubuntu-Install-Debs.html).

## Foxglove Integration

The development environment includes the [Foxglove ROS bridge](https://docs.foxglove.dev/docs/visualization/ros-foxglove-bridge) for real-time visualization of ROS2 data. The bridge:

- Auto-launches on system startup via systemd service
- Runs on the default port 8765
- Is accessible from the host machine via port forwarding
- Supports all ROS2 message types and services
- Provides real-time visualization capabilities through Foxglove Studio

To connect to the Foxglove bridge from your host machine, use the WebSocket URL: `ws://localhost:8765`

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Support

For issues and questions, please open an issue in this repository.