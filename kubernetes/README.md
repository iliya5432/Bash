# Kubernetes Installation Script for CentOS-7

This script automates the installation of Kubernetes on a CentOS-7 operating system. It includes configuration steps for essential system requirements, such as disabling swap and opening firewall ports.
- ``Note: The script has been tested exclusively in a virtual environment using CentOS-7 image with PLASMA environment.``

## Network Configuration

Before running the script, ensure your network settings match the desired number of nodes in the cluster. Use the following example:

```bash
hostnamectl set-hostname master-node
sudo echo "192.168.1.15 master-node.domain master-node" >> /etc/hosts
sudo echo "192.168.1.16 worker1-node.domain worker1-node" >> /etc/hosts
```

## Script Setup
After configuring the network, execute the following commands:

```
sudo yum install dos2unix -y
sudo dos2unix kubeinstall.sh
```
##### This ensures the script is in the correct Unix file format. To verify, run:
```
sudo vim kubeinstall.sh

# Press Escape
# Type :set ff?
# This should display the current file format.
```
- ``Note: Ensure the script has the correct permissions using:``

```
sudo chmod +755 kubeinstall.sh
```
