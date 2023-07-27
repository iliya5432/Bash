#!/bin/bash
read -s -p "Please enter you password: " passwd
echo "$passwd" | sudo apt install sshpass
i=0
echo "Adding hosts to /etc/ansible/hosts: "
cat contport | while read line
do
   echo "yes" | sshpass -p $passwd ssh-copy-id -p $line -i ~/.ssh/id_rsa.pub -o StrictHostKeyChecking=no ansible@localhost
   ((i = i+1))
   if [[ $line -ne "" ]]; then
   echo "$passwd" | sudo echo "host$i ansible_ssh_host=127.0.0.1 ansible_ssh_port=$line" | sudo tee -a /etc/ansible/hosts
   fi
done
