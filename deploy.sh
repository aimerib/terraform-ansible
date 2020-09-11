#!/usr/bin/env bash

# This simple script just wraps all the tools into a single command
# necessary to deploy a droplet ready to host docker container workloads

set -e
echo "Starting deployment"
./terraform-ansible.sh terraform apply -auto-approve && \
echo "Waiting for droplet to become active" && \
sleep 30 && \
./terraform-ansible.sh ansible-playbook -i inventory playbook.yml

if [[ $? -eq 0 ]]; then
  echo "Deployment completed"
  exit 0;
else
  echo "Deployment failed with error code: $?"
  exit $?
fi;
