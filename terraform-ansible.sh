#!/usr/bin/env bash

# Usage:
# ./terraform-ansible.sh terraform -v
# ./terraform-ansible.sh ansible --version
#
# This script proxies the terraform and ansible
# commands through a docker container configure
# to run as a non-sudo user. This allows developers
# to initiate and execute terraform and ansible
# commands on the host, making this a portable
# environment to deploy your projects.
#
# This strategy can be used to implement deployemnts
# in CI with careful planning.
#
# I'm using my own image here, but you can build
# your own from the Dockerfile in this repository.

start_terraform(){
  docker run -it --rm -v `pwd`:/home/sloth \
  aimeri/terraform-ansible terraform $@
  if [[ $? -ne 0 ]]; then
    exit 1;
  fi;
}
start_ansible(){
  docker run -it --rm -v `pwd`:/home/sloth \
  -e ANSIBLE_HOST_KEY_CHECKING=False \
  aimeri/terraform-ansible ansible $@
  if [[ $? -ne 0 ]]; then
    exit 1;
  fi;
}
start_ansible_playbook(){
  docker run -it --rm -v `pwd`:/home/sloth \
  -e ANSIBLE_HOST_KEY_CHECKING=False \
  aimeri/terraform-ansible ansible-playbook $@
  if [[ $? -ne 0 ]]; then
    exit 1;
  fi;
}

if [[ "$#" -gt 0 ]]; then
    case $1 in
        terraform)        start_terraform ${@:2};;
        ansible)          start_ansible ${@:2};;
        ansible-playbook) start_ansible_playbook ${@:2};;
        *) echo "Unknown parameter passed: $1"; exit 1 ;;
    esac
    shift
fi
