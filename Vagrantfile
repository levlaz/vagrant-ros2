# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  # Use Ubuntu 24.04 LTS ARM64 for M Series Macs
  config.vm.box = "levlaz_org/ubuntu-24-arm"
  
  # Configure the VM
  config.vm.hostname = "ros2-dev"
  
  # Memory and CPU allocation for M Series Mac (ARM64)
  config.vm.provider "vmware_desktop" do |v|
    v.memory = 8192
    v.cpus = 4
    v.gui = true
    v.vmx["displayName"] = "Vagrant ROS2 VM"

    # Enable VNC
    v.vmx["RemoteDisplay.vnc.enabled"] = "TRUE"
    v.vmx["RemoteDisplay.vnc.port"] = "5900"
    v.vmx["RemoteDisplay.vnc.password"] = "vagrant"
    v.vmx["RemoteDisplay.vnc.ip"] = "127.0.0.1"
  end
  
  # Network configuration for ROS2
  config.vm.network "private_network", ip: "192.168.56.10"
  
  # Shared folder for development
  config.vm.synced_folder ".", "/vagrant", type: "rsync"
  
  # Port forwarding for ROS2 tools (if needed)
  config.vm.network "forwarded_port", guest: 11311, host: 11311, id: "roscore"
  
  # Port forwarding for Foxglove bridge (default port 8765)
  config.vm.network "forwarded_port", guest: 8765, host: 8765, id: "foxglove-bridge"

  # Port forwarding for VNC
  config.vm.network "forwarded_port", guest: 5900, host: 5900, id: "vnc"
  
  # Provisioning script to install ROS2 Jazzy
  config.vm.provision "shell", inline: <<-SHELL
    #!/bin/bash
    set -e
    
    echo "Starting ROS2 Jazzy installation..."
    
    # Update system
    sudo apt-get update
    sudo apt-get upgrade -y
    
    # Install essential packages
    sudo apt-get install -y curl wget git vim build-essential software-properties-common
    
    # Set locale for UTF-8 support
    sudo apt-get install -y locales
    sudo locale-gen en_US en_US.UTF-8
    sudo update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
    export LANG=en_US.UTF-8
    
    # Enable required repositories
    sudo add-apt-repository universe
    
    # Install ROS 2 apt source
    export ROS_APT_SOURCE_VERSION=$(curl -s https://api.github.com/repos/ros-infrastructure/ros-apt-source/releases/latest | grep -F "tag_name" | awk -F\\" '{print $4}')
    curl -L -o /tmp/ros2-apt-source.deb "https://github.com/ros-infrastructure/ros-apt-source/releases/download/${ROS_APT_SOURCE_VERSION}/ros2-apt-source_${ROS_APT_SOURCE_VERSION}.$(. /etc/os-release && echo ${UBUNTU_CODENAME:-${VERSION_CODENAME}})_all.deb"
    sudo dpkg -i /tmp/ros2-apt-source.deb
    
    # Update package lists
    sudo apt-get update
    
    # Install development tools
    sudo apt-get install -y ros-dev-tools
    
    # Install ROS 2 Jazzy Desktop (includes RViz, demos, tutorials)
    sudo apt-get install -y ros-jazzy-desktop
    
    # Install Foxglove ROS bridge
    sudo apt-get install -y ros-jazzy-foxglove-bridge
    
    # Install additional ROS 2 tools
    sudo apt-get install -y python3-pip python3-venv
    
    # Initialize rosdep (only if not already initialized)
    if [ ! -f "/etc/ros/rosdep/sources.list.d/20-default.list" ]; then
      sudo rosdep init
    fi
    rosdep update
    
    # Set up Python virtual environment for ROS2
    echo "Setting up Python virtual environment for ROS2..."
    
    # Create ROS2 virtual environment (only if it doesn't exist)
    if [ ! -d "/home/vagrant/ros2_venv" ]; then
      sudo -u vagrant python3 -m venv /home/vagrant/ros2_venv
    fi
    
    # Activate virtual environment and install ROS2 Python packages
    sudo -u vagrant bash -c "source /home/vagrant/ros2_venv/bin/activate && \
      pip install --upgrade pip && \
      pip install \
        colcon-common-extensions \
        colcon-ros \
        colcon-cd \
        colcon-lint \
        colcon-mixin \
        colcon-parallel-executor \
        colcon-pkg-config \
        colcon-powershell \
        colcon-python-setup-py \
        colcon-recursive-crawl \
        colcon-ros-bazel \
        colcon-test-result \
        colcon-zsh \
        rosdep \
        vcstool"
    
    # Create auto-activation script
    sudo -u vagrant tee /home/vagrant/.bashrc_ros2 > /dev/null << 'EOF'
# ROS2 Python Virtual Environment Auto-activation
if [ -f "/home/vagrant/ros2_venv/bin/activate" ]; then
    source /home/vagrant/ros2_venv/bin/activate
    source /opt/ros/jazzy/setup.bash
    echo "ROS2 Python virtual environment activated"
fi
EOF
    
    # Add to bashrc (only if not already added)
    if ! grep -q "source /home/vagrant/.bashrc_ros2" /home/vagrant/.bashrc; then
      echo "source /home/vagrant/.bashrc_ros2" >> /home/vagrant/.bashrc
    fi
    
    # Set up environment for vagrant user
    echo 'source /opt/ros/jazzy/setup.bash' >> /home/vagrant/.bashrc
    
    # Create workspace directory
    sudo -u vagrant mkdir -p /home/vagrant/ros2_ws/src
    
    echo "Python virtual environment setup complete!"
    echo 'source /opt/ros/jazzy/setup.bash' >> /root/.bashrc
    
    # Create systemd service for Foxglove bridge auto-launch
    sudo tee /etc/systemd/system/foxglove-bridge.service > /dev/null <<EOF
[Unit]
Description=Foxglove ROS Bridge
After=network.target

[Service]
Type=simple
User=vagrant
Environment=ROS_DOMAIN_ID=0
ExecStart=/bin/bash -c 'source /opt/ros/jazzy/setup.bash && ros2 launch foxglove_bridge foxglove_bridge_launch.xml'
Restart=always
RestartSec=5

[Install]
WantedBy=multi-user.target
EOF
    
    # Enable and start Foxglove bridge service
    sudo systemctl daemon-reload
    sudo systemctl enable foxglove-bridge.service
    
    # Create workspace directory
    mkdir -p /home/vagrant/ros2_ws/src
    chown -R vagrant:vagrant /home/vagrant/ros2_ws
    
    # Install additional development tools
    sudo apt-get install -y gdb valgrind
    
    # Install additional useful packages
    sudo apt-get install -y htop tree tmux
    
    # Clean up
    sudo apt-get autoremove -y
    sudo apt-get clean
    
    echo "ROS2 Jazzy installation completed!"
    echo "To start using ROS2, run: source /opt/ros/jazzy/setup.bash"
  SHELL
end
