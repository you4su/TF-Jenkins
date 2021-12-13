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
 sudo apt-get install openjdk-11-jdk -y && \
 echo "------------------------------"
 echo "JDK install done."
 sudo apt-get install gcc g++ make -y && \
#Install python pip3
  sudo apt-get -y install python3-pip && sudo apt-get install -y build-essential libffi-dev-python-dev && \
  sudo apt-get install -y nfs-common && sudo systemctl restart systemd-logind && \
  pip3 install python-bcrypt -y && \
  echo "Python 3 install done"
#Install NodeJS
  #sudo apt-get install nodejs npm -y \ return 8.5v
  sudo apt-get install npm -y && \
  curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash - && \
  sudo apt-get install nodejs -y && \
  curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | gpg --dearmor | sudo tee /usr/share/keyrings/yarnkey.gpg >/dev/null && \
  echo "deb [signed-by=/usr/share/keyrings/yarnkey.gpg] https://dl.yarnpkg.com/debian stable main" | sudo tee /etc/apt/sources.list.d/yarn.list && \
  sudo apt-get update -y && \
  sudo npm install yarn --global -y && \
#Install Git
  sudo apt-get install git-all -y && \
#Install zip
  sudo apt-get install zip -y && \
#Install AWS Cli
  curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
  unzip awscliv2.zip && \
  sudo ./aws/install -i /usr/local/aws-cli -b /usr/local/bin && \
#Install Angular cli
  sudo npm install -g @angular/cli@11.1.2
