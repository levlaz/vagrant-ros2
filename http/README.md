# Ubuntu Autoinstall Configuration

This directory contains the cloud-init configuration files used for automated Ubuntu installation.

## Files

- `user-data`: Cloud-init configuration for automated installation
- `meta-data`: Instance metadata for the installation

## How it works

Packer uses these files to automatically install Ubuntu without manual intervention:

1. The ISO is booted with autoinstall parameters
2. Cloud-init uses these files to configure the system
3. The vagrant user is created with password authentication
4. SSH is enabled for remote access
5. Basic packages are installed

This enables fully automated builds without requiring manual interaction in VMware Fusion.
