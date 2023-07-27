#!/bin/bash
read -s -p "Please enter you password: " passwd
cat ./conthash | while read line
do
   sudo docker rm -f "$line"
   sudo sed -i "/$line/d" ./conthash
done

cat ./contport | while read line
do
   sed -i "/$line/d" ./contport
   echo "$passwd" | sudo sed -i "/$line/d" /etc/ansible/hosts
done
