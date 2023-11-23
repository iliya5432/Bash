# Prerequisites

Ensure you have the following tools installed: 
- Docker
- Ansible
- SSH
- sshpass

## Docker Image Setup

Build a Docker image featuring an installed SSH server. Create an "ansible" user and grant it sudo privileges. Utilize the provided "Dockerfile" for image creation. Please note that the "ansible" user creation instruction is intentionally omitted from the file.

**Important Steps:**
- Run `ssh-keygen` to copy the default SSH public key from the Ansible master to the slave nodes.
- Confirm that the last line of the `/etc/ansible/hosts` file is an empty group, for example, `[servers]`.

## Scripts

### docker_setup.sh

Execute this script to launch containers with internal port 22 and external ports determined by user input, using the specified Docker image.

**Note:**
- The `-p` flag designates a port base range. For instance, with 3 containers and a port base range of 2000, the external ports will be: 5001, 5002, 5003.

### ansible_pubkey.sh

Run this script to copy the public SSH key from `~/.ssh/id_rsa.pub` to the designated container, using the "ansible" user. Additionally, append the new hosts to the `/etc/ansible/hosts` file.

### docker_undo.sh

Execute this script to remove the containers and their corresponding entries from the `/etc/ansible/hosts` file.
