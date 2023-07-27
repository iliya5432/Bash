sudo yum update -y && sudo yum upgrade -y
sudo sed -i '/swap/d' /etc/fstab
sudo swapoff -a

echo "# This file controls the state of SELinux on the system." > /etc/selinux/config
echo "# SELINUX= can take one of these three values:" >> /etc/selinux/config
echo "#  enforcing - SELinux security policy is enforced." >> /etc/selinux/config
echo "#  permissive - SELinux prints warnings instead of enforcing." >> /etc/selinux/config
echo "#  disabled - No SELinux policy is loaded." >> /etc/selinux/config
echo "SELINUX=disabled" >> /etc/selinux/config
echo "# SELINUXTYPE= can take one of these two values:" >> /etc/selinux/config
echo "#  targeted - Targeted processes are protected," >> /etc/selinux/config
echo "#  mls - Multi Level Security protection." >> /etc/selinux/config
echo "SELINUXTYPE=targeted" >> /etc/selinux/config

sudo systemctl enable firewalld
sudo systemctl start firewalld

sudo firewall-cmd --permanent --add-port=6443/tcp
sudo firewall-cmd --permanent --add-port=2379-2380/tcp
sudo firewall-cmd --permanent --add-port=8472/udp
sudo firewall-cmd --permanent --add-port=10250/tcp
sudo firewall-cmd --reload

sudo yum install -y yum-utils device-mapper-persistent-data lvm2
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo yum install -y docker-ce docker-ce-cli containerd.io
sudo systemctl enable docker
sudo systemctl start docker

echo "[kubernetes]" > /etc/yum.repos.d/kubernetes.repo
echo "name=Kubernetes" >> /etc/yum.repos.d/kubernetes.repo
echo "baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64" >> /etc/yum.repos.d/kubernetes.repo
echo "enabled=1" >> /etc/yum.repos.d/kubernetes.repo
echo "gpgcheck=1" >> /etc/yum.repos.d/kubernetes.repo
echo "repo_gpgcheck=1" >> /etc/yum.repos.d/kubernetes.repo
echo "gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg" >> /etc/yum.repos.d/kubernetes.repo

sudo yum install -y kubelet kubeadm kubectl
sudo systemctl enable kubelet
sudo systemctl start kubelet

echo "overlay" > /etc/modules-load.d/containerd.conf
echo "br_netfilter" >> /etc/modules-load.d/containerd.conf


modprobe overlay && \
modprobe br_netfilter

yum install yum-utils -y
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
CONTAINDERD_CONFIG_PATH=/etc/containerd/config.toml && \
rm "${CONTAINDERD_CONFIG_PATH}" && \
containerd config default > "${CONTAINDERD_CONFIG_PATH}" && \
sed -i "s/SystemdCgroup = false/SystemdCgroup = true/g"  "${CONTAINDERD_CONFIG_PATH}"
systemctl enable --now containerd && \
systemctl restart containerd
