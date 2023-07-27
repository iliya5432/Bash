Prerequisites: 
Tools to be installed: docker, ansible, ssh, sshpass.
Actions: you have to build a docker image with ssh server installed and "ansible" user created and added to sudoers,
you can use "Dockerfile" in order to build the image, notice the file does NOT contain "ansible" user creation instruction.

Note: you got to run ssh-keygen in order to copy the default ssh public key from the ansible master to the slaves, AND make sure the /etc/ansible/hosts file's last line is an empty group. (Example: [servers]).


docker_setup.sh - runs a number of containers with internal port 22 and external port by user's usage, using desired image.
note: the '-p' flag indicates a port base range, let's say you have 3 containers and you've chosen the port base range to be 2000,
the containers external ports will be: 5001, 5002, 5003.

ansible_pubkey.sh - copies the public ssh key from ~/.ssh/id_rsa.pub to the desired container using user named ansible,
and adds the new hosts to /etc/ansible/hosts.

docker_undo.sh - removes containers and new entries from /etc/ansible/hosts.

