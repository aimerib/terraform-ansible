resource "digitalocean_droplet" "do-droplet-1" {
  image = "ubuntu-20-04-x64"
  name = "do-droplet-1"
  region = "nyc3"
  size = "s-1vcpu-1gb"
  private_networking = true
  ssh_keys = [var.ssh_fingerprint]
}

resource "null_resource" "ansible-provision" {
  depends_on = [
    digitalocean_droplet.do-droplet-1,
  ]

  provisioner "local-exec" {
    command = "echo '${digitalocean_droplet.do-droplet-1.name} ansible_host=${digitalocean_droplet.do-droplet-1.ipv4_address} ansible_ssh_user=root ansible_python_interpreter=/usr/bin/python3' > inventory"
  }
}

output "ip" {
  value = digitalocean_droplet.do-droplet-1.ipv4_address
}
