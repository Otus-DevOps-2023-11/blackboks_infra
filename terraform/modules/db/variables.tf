variable "public_key_path" {
  description = "Path to the public key used for ssh access"
}
variable "subnet_id" {
  description = "Subnet"
}
variable db_disk_image {
description = "Disk image for reddit db"
default = "fd8rl2902l5hl5pdhojn"
}
variable "db_name" {
  description = "Database instance name"
}
variable "private_key_path" {
  description = "Path to the private key used for ssh access"
}
