terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "1.22.2"
    }
  }
}

variable "do_token" {}
variable "ssh_fingerprint" {}

provider "digitalocean" {
  token = var.do_token
}
