resource "digitalocean_ssh_key" "personal_laptop_key" {
  name       = "CIAN-X1YOGA (TCD email)"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDYiNLw++V2Ajl1h8FGvfpGNIOGnuhdunz1mcJ5qZt1U/URZ93BI6coN38p6e6CPEkkUwhkq3cVhi5EfBCh6IUh0Tb8gHZ0fs5FCnMjRGapjFFGMjfGcyRWCOGvPDrOnztSO+SU4wOf18gAoMmdG8fgCiv4sJsGu1Pb7W26VYNySvfVRcvFyXQI9HhvjFvP2xJ0gDNiT0IPYrnS3wHyM5G9RuO5Mmz5AppmlHq19poYm5Tmb6N7Jf1LDAl/73B77YKFRCI3t7z5ojxZdsdbDq14O3dGxWJ95S5PgK0lXFCrgDkwRXKqW6cyAhQ5ccryn6LSMgRSmDqLNEUaOYXFxyLvYXRigXe0VDZGTMNJpIfOqdcGc25TRce5jTrf5OM/m6zBnbtiBcqWyCiNkXKeDxZ1MifUONB+j3zcnWJopLCTl8k3diKghquja6mQMxIaRwjwUnXOQbzSGQWd7jnON0sprK9RTJ47wQbTY9sH3VSFe2YIv0/NwThYiwb0SCDZaZbltiGhFEhVkJeJhtEHANzRc2ojT0LRUNPgXqJdpwBDI7gfkgZ1n9jkMwNZTC7VTNuM6kldWc3yyDnw9XPehyVvt/MBhD7W9U5qOc2Tbq+lD/GhW/7XYC1MI6vt95QLBT5QFkj1mKa2XUGaSMYHiXj5p2wtCTwdSDBpNIm8ZMeb0Q== mawhinnc@tcd.ie"
}

resource "digitalocean_ssh_key" "personal_desktop_key" {
  name       = "CIAN-DESKTOP"
  public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIaexsTtRC/TcLeoyZW/IVzpgVcgJZi4L7g29S7RvegO cianmawhinney@gmail.com"
}

resource "digitalocean_tag" "production" {
  name = "prod"
}

resource "hcloud_ssh_key" "personal_laptop_key" {
  name       = "CIAN-X1YOGA (TCD email)"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDYiNLw++V2Ajl1h8FGvfpGNIOGnuhdunz1mcJ5qZt1U/URZ93BI6coN38p6e6CPEkkUwhkq3cVhi5EfBCh6IUh0Tb8gHZ0fs5FCnMjRGapjFFGMjfGcyRWCOGvPDrOnztSO+SU4wOf18gAoMmdG8fgCiv4sJsGu1Pb7W26VYNySvfVRcvFyXQI9HhvjFvP2xJ0gDNiT0IPYrnS3wHyM5G9RuO5Mmz5AppmlHq19poYm5Tmb6N7Jf1LDAl/73B77YKFRCI3t7z5ojxZdsdbDq14O3dGxWJ95S5PgK0lXFCrgDkwRXKqW6cyAhQ5ccryn6LSMgRSmDqLNEUaOYXFxyLvYXRigXe0VDZGTMNJpIfOqdcGc25TRce5jTrf5OM/m6zBnbtiBcqWyCiNkXKeDxZ1MifUONB+j3zcnWJopLCTl8k3diKghquja6mQMxIaRwjwUnXOQbzSGQWd7jnON0sprK9RTJ47wQbTY9sH3VSFe2YIv0/NwThYiwb0SCDZaZbltiGhFEhVkJeJhtEHANzRc2ojT0LRUNPgXqJdpwBDI7gfkgZ1n9jkMwNZTC7VTNuM6kldWc3yyDnw9XPehyVvt/MBhD7W9U5qOc2Tbq+lD/GhW/7XYC1MI6vt95QLBT5QFkj1mKa2XUGaSMYHiXj5p2wtCTwdSDBpNIm8ZMeb0Q== mawhinnc@tcd.ie"
}

resource "hcloud_ssh_key" "personal_desktop_key" {
  name       = "CIAN-DESKTOP"
  public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIaexsTtRC/TcLeoyZW/IVzpgVcgJZi4L7g29S7RvegO cianmawhinney@gmail.com"
}

# module "hyq_mc" {
#   source = "./modules/digitalocean-minecraft"

#   name = "hyq-mc"
#   ssh_keys = [
#     digitalocean_ssh_key.personal_key,
#   ]
#   resource_tags = [
#     digitalocean_tag.production
#   ]
# }


module "k3s-eu-central" {
  source = "./modules/hetzner-k3s-cluster"
  ssh_keys = [hcloud_ssh_key.personal_desktop_key, hcloud_ssh_key.personal_laptop_key]
}


