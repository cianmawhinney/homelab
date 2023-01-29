# resource "digitalocean_volume" "docker_data" {
#   region                  = "nyc1"
#   name                    = "example-volume"
#   size                    = 120
#   initial_filesystem_type = "ext4"
#   description             = "an example volume"
# }

# resource "digitalocean_droplet" "docker_host" {
#   name = "example-droplet"
#   size   = "s-1vcpu-1gb"
#   image  = "ubuntu-22-04-x64"
#   region = "nyc1"
# }

# resource "digitalocean_volume_attachment" "foobar" {
#   droplet_id = digitalocean_droplet.docker_host.id
#   volume_id  = digitalocean_volume.docker_data.id
# }

# Feel like there should be a better way to do this than listing them out as separate resources
resource "digitalocean_ssh_key" "personal_key" {
  name = "CIAN-X1YOGA (TCD email)"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDYiNLw++V2Ajl1h8FGvfpGNIOGnuhdunz1mcJ5qZt1U/URZ93BI6coN38p6e6CPEkkUwhkq3cVhi5EfBCh6IUh0Tb8gHZ0fs5FCnMjRGapjFFGMjfGcyRWCOGvPDrOnztSO+SU4wOf18gAoMmdG8fgCiv4sJsGu1Pb7W26VYNySvfVRcvFyXQI9HhvjFvP2xJ0gDNiT0IPYrnS3wHyM5G9RuO5Mmz5AppmlHq19poYm5Tmb6N7Jf1LDAl/73B77YKFRCI3t7z5ojxZdsdbDq14O3dGxWJ95S5PgK0lXFCrgDkwRXKqW6cyAhQ5ccryn6LSMgRSmDqLNEUaOYXFxyLvYXRigXe0VDZGTMNJpIfOqdcGc25TRce5jTrf5OM/m6zBnbtiBcqWyCiNkXKeDxZ1MifUONB+j3zcnWJopLCTl8k3diKghquja6mQMxIaRwjwUnXOQbzSGQWd7jnON0sprK9RTJ47wQbTY9sH3VSFe2YIv0/NwThYiwb0SCDZaZbltiGhFEhVkJeJhtEHANzRc2ojT0LRUNPgXqJdpwBDI7gfkgZ1n9jkMwNZTC7VTNuM6kldWc3yyDnw9XPehyVvt/MBhD7W9U5qOc2Tbq+lD/GhW/7XYC1MI6vt95QLBT5QFkj1mKa2XUGaSMYHiXj5p2wtCTwdSDBpNIm8ZMeb0Q== mawhinnc@tcd.ie"
}

resource "digitalocean_droplet" "vault" {
  name = "vault-01"
  size   = "s-1vcpu-1gb"
  image  = "rockylinux-9-x64"
  region = "lon1"

  ssh_keys = [
    digitalocean_ssh_key.personal_key.fingerprint
  ]
}
