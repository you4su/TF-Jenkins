#!/usr/bin/bash -x

sudo apt-get update -y && sudo apt-get upgrade -y \
echo "updrage done"

#Debconf
  sudo chmod 777 /home/ubuntu
  echo 'debconf debconf/frontend select Noninteractive' | sudo debconf-set-selections && \
  echo 'config successfull' & \
  sudo apt-get install dialog apt-utils -y && sudo apt-get install -y -q && \
  sudo chmod 777 /var/cache//debconf/ && sudo chmod 777 /var/cache/debconf/passwords.dat && \
  sudo apt-get install -y gnupg2 && \
  ls -la /home/ubuntu
#Added command
  curl -O https://s3.amazonaws.com/ec2rescuelinux/ec2rl.key && \
  gpg2 --imort ec2rl.key && \
  curl -O https://s3.amazonaws.com/ec2rescuelinux/ec2rl.tgz.sig && \
  gpg2 --verify ./ec2rl.tgz.sig
#Install open jdk
 sudo apt-get install openjdk-11-jdk -y \
 echo "------------------------------"
 echo "JDK install done."
#Install python pip3
  sudo apt-get -y install python3-pip && sudo apt-get install -y build-essential libffi-dev-python-dev && \
  sudo apt-get install -y nfs-common && sudo systemctl restart systemd-logind && \
  pip3 install python-bcrypt -y \
  echo "Python 3 install done"

#Install NodeJS
  sudo apt-get install nodejs npm -y \
#Install Git
  sudo apt-get install git-all -y \
#Install zip
  sudo apt-get install zip -y
