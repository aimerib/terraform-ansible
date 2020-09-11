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

while [[ "$#" -gt 0 ]]; do
    case $1 in
        terraform) docker run -it --rm -v `pwd`:/home/sloth --env \
                   TF_LOG=TRACE aimeri/terraform-ansible terraform ${@:2};;
        ansible)   docker run -it --rm -v `pwd`:/home/sloth \
                   aimeri/terraform-ansible ansible ${@:2};;
        *) echo "Unknown parameter passed: $1"; exit 1 ;;
    esac
    shift
done
