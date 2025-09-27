# ROS2 Development Environment for M Series Mac

This repository contains tooling to create a development environment for working with ROS2 on an M Series Mac using VMware Fusion.

## Overview

This project provides a virtualized ROS2 development environment that runs on Apple Silicon (M Series) Macs using VMware Fusion. This setup allows you to develop and test ROS2 applications in a Linux environment while using Mac.

## Prerequisites

- Apple Silicon Mac (M1, M2, M3, M4, etc.)
- VMware Fusion (latest version recommended)
- Vagrant (latest version recommended)
  - [Vagrant Documentation](https://www.vagrantup.com/docs)
  - VMware Fusion provider for Vagrant
    - [Vagrant VMware Provider Documentation](https://www.vagrantup.com/docs/providers/vmware)
    - [VMware Fusion Provider Plugin](https://github.com/hashicorp/vagrant-vmware-desktop)
- Packer (for developing this project)
  - [Packer Documentation](https://developer.hashicorp.com/packer/docs)
- Sufficient disk space for the virtual machine
- At least 8GB RAM (16GB recommended)

## Features

- Pre-configured Ubuntu Linux virtual machine
- ROS2 installation and setup
- Development tools and dependencies
- Network configuration for ROS2 communication
- Shared folder setup for code development

## Quick Start

1. Clone this repository
2. Install Vagrant and VMware Fusion
3. Run `vagrant up` to create and provision the virtual machine
4. Run `vagrant ssh` to access the ROS2 development environment
5. Start developing with ROS2!

## Building the Custom Box

This project includes Packer configuration to build a custom Ubuntu Noble (24.04) box with ROS2 Jazzy pre-installed.

### Prerequisites for Building

1. Download Ubuntu Noble 24.04 LTS ISO
2. Create a VMware Fusion VM with Ubuntu Noble
3. Install VMware Tools and configure the VM
4. Export the VM and note the VMX file path

### Building Steps

1. Set the SOURCE_VMX environment variable to your Ubuntu Noble VMX file:
   ```bash
   export SOURCE_VMX=/path/to/your/ubuntu-noble.vmx
   ```

2. Run the build script:
   ```bash
   ./build.sh
   ```

3. Add the custom box to Vagrant:
   ```bash
   vagrant box add ros2-jazzy-ubuntu-noble ros2-jazzy-ubuntu-noble-vmware.box
   ```

4. Use the custom box:
   ```bash
   vagrant up
   ```

## Project Structure

```
├── README.md           # This file
├── .gitignore         # Git ignore rules
├── LICENSE            # MIT License
├── packer.json        # Packer configuration for building custom box
├── Vagrantfile.template # Template for Vagrant configuration
└── build.sh           # Build script for creating custom box
```

## ROS2 Version

This project uses ROS2 Jazzy Jalisco, the latest LTS version, running on Ubuntu Noble 24.04 LTS. The configuration follows the [official ROS2 Jazzy installation documentation](https://docs.ros.org/en/jazzy/Installation/Ubuntu-Install-Debs.html).

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Support

For issues and questions, please open an issue in this repository.