# Terraform and Ansible settings for DO deployment
This repo will:
* Instantiate a new droplet in DO
* Run Ansible playbook to
  * configure droplet for non-root user
  * install docker
  * copy docker.env to droplet
  * copy origin certs from Cloudflare to droplet
