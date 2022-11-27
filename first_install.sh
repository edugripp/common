#!/bin/bash

if ! [ $(id -u) = 0 ]; then
   echo -e "The script need to be run as root." >&2
   exit 1
fi

if [ $USER ]; then
    real_user=$USER
else
    real_user=$(whoami)
fi

CYAN="\033[97;46m"
RED="\033[97;41m"
NC='\033[0m' # No Color

#echo -e "${CYAN} Enter your user: ${NC}"

#read my_user

my_user=$(ls "/home")

echo -e "${CYAN} user ${NC} ${RED} $my_user ${NC} ${NC}"

#update
echo -e "${CYAN} update ${NC}"
apt-get update -y

#installing htop
echo -e "${CYAN} install htop ${NC}"
apt-get install -y htop

#installing terminator
echo -e "${CYAN} install terminator ${NC}"
apt-get install -y terminator

#installing chrome
echo -e "${CYAN} installing chrome ${NC}"
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
dpkg -i google-chrome-stable_current_amd64.deb
rm -f google-chrome-stable_current_amd64.deb

#installing code
echo -e "${CYAN} installing code ${NC}"
apt-get install -y snapd snapd-xdg-open
snap install --classic code

#installing postman
echo -e "${CYAN} installing postman ${NC}"
snap install postman

#installing dbeaver
echo -e "${CYAN} installing dbeaver ${NC}"
echo -e "deb https://dbeaver.io/debs/dbeaver-ce /" | tee /etc/apt/sources.list.d/dbeaver.list
wget -O - https://dbeaver.io/debs/dbeaver.gpg.key | apt-key add -
apt-get update
apt-get install dbeaver-ce

#installing git
echo -e "${CYAN} installing git ${NC}"
apt-get install -y git

#installing pip for python 2 and 3
echo -e "${CYAN} installing pip ${NC}"
apt install -y python-pip
apt install -y python3-pip

#install node
echo -e "${CYAN} installing node and pnpm ${NC}"
curl -fsSL https://deb.nodesource.com/setup_19.x | bash - &&\
apt-get install -y curl gcc g++ make
apt-get install -y nodejs 
npm install -g pnpm

#install java 11
echo -e "${CYAN} installing java 11 ${NC}"
apt install -y openjdk-11-jdk

#installing spotify
echo -e "${CYAN} installing spotify ${NC}"
snap install spotify

#installing intellij
echo -e "${CYAN} installing pycharm professional ${NC}"
snap install pycharm-professional --classic

#installing intellij
echo -e "${CYAN} installing intellij ultimate ${NC}"
snap install intellij-idea-ultimate --classic

#installing docker
echo -e "${CYAN} installing docker ${NC}"
apt-get update -y
apt-get install -y \
    apt-transport-https \
    ca-certificates \
    software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
apt-key fingerprint 0EBFCD88
add-apt-repository -y \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
apt-get update -y
apt-get install -y docker-ce
groupadd docker
echo -e "${CYAN} adding ${NC} ${RED} $my_user ${NC} ${CYAN} to docker group, enabling docker without sudo ${NC}"
usermod -aG docker $my_user

#installing packages for monitor the raspberrys :)
echo -e "${CYAN} installing packages for monitor the raspberrys :) ${NC}"
apt-get install -y jq
apt-get install -y sshpass
apt-get install -y openvpn

#install ansible
echo -e "${CYAN} installing ansible ${NC}"
apt-get install -y software-properties-common
apt-add-repository --yes --update ppa:ansible/ansible
apt-get install -y ansible

#install terraform
echo -e "${CYAN} installing terraform ${NC}"
apt-get install -y unzip
wget https://releases.hashicorp.com/terraform/1.3.5/terraform_1.3.5_linux_amd64.zip
unzip terraform_1.3.5_linux_amd64.zip
mv terraform /usr/local/bin/
terraform --version 
rm -f terraform_1.3.5_linux_amd64.zip

#install packer
echo -e "${CYAN} installing packer ${NC}"
apt-get install -y packer

#install kubernetes
echo -e "${CYAN} installing kubernetes ${NC}"
sudo -u $my_user curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo -u $my_user curl -LO "https://dl.k8s.io/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"
sudo -u $my_user echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check
install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
sudo -u $my_user kubectl version --client

#installing zsh
echo -e "${CYAN} installing zsh ${NC}"
apt install -y zsh
apt -y autoremove
sudo -u $my_user sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
