#!/usr/bin/env bash

set -o errexit
set -o pipefail


_setup() {
  # install jenkins dependencies
  sudo apt update
  sudo apt install openjdk-8-jdk -y

  # add Jenkins debian repository
  printf '\e[1;34m%-6s\e[m' "Add gpg key"
  wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -

  if [ $? -ne 0 ]; then
    printf '\e[1;34m%-6s\e[m' "failed to authenticate this repository"
    exit 1
  else
    echo ""
    printf '\e[1;34m%-6s\e[m' "Ok: Add key was successful"
  fi
}

_install_jenkins() {
  # install jenkins
  sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
  if [ $? -ne 0 ]; then
    printf '\e[1;34m%-6s\e[m' "Failed to update sources list"
    exit 1
  else
    printf '\e[1;34m%-6s\e[m' "Installing jenkins"
    sudo apt update
    sudo apt install jenkins -y
  fi
  # allow 8080 on firewall
  sudo ufw allow 8080
}

_install_docker() {
  printf '\e[1;34m%-6s\e[m' "Installing docker"
  sudo apt install docker.io
  if [ $? -ne 0 ]; then
    echo "Failed to install docker"
    exit 1
  else 
    printf '\e[1;34m%-6s\e[m' "Starting docker daemon"
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

main $@