#!/usr/bin/env bash

set -o errexit
set -o pipefail


_setup() {
  # install jenkins dependencies
  sudo apt update
  sudo apt install openjdk-8-jdk -y

  # add Jenkins debian repository
  echo "Add gpg key"
  wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -

  if [ $? -ne 0 ]; then
    echo "failed to authenticate this repository"
    exit 1
  else
    echo "Ok: Add key was successful"
    exit 0
  fi
}

_install_jenkins() {
  # install jenkins
  sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
  if [ $? -ne 0 ]; then
    echo "Failed to update sources list"
    exit 1
  else
    echo "Installing Jenkins"
    sudo apt update
    sudo apt install jenkins -y
    exit 0
  fi
  # allow 8080 on firewall
  sudo ufw allow 8080
}

_install_docker() {
  sudo apt install docker.io
  if [ $? -ne 0 ]; then
    echo "Failed to install docker"
    exit 1
  else 
    echo "Starting docker daemon"
    sudo systemctl start docker
    sudo systemctl enable docker
  fi

  # Add jenkins user to docker user group
  sudo usermod -aG docker jenkins
}

main(){
  _setup
  _install_jenkins
  _install_docker
}