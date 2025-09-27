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

## Project Structure

```
├── README.md           # This file
├── .gitignore         # Git ignore rules
├── LICENSE            # MIT License
├── Vagrantfile        # Vagrant configuration
└── docs/              # Documentation (coming soon)
```

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Support

For issues and questions, please open an issue in this repository.
