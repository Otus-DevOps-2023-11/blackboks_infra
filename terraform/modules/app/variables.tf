variable "public_key_path" {
  description = "Path to the public key used for ssh access"
}
variable "subnet_id" {
  description = "Subnet"
}
variable "app_disk_image" {
  description = "Disk image for reddit app"
  default     = "fd80pap0ro1dfp3v8mdk"
}
variable "app_name" {
  description = "Application name"
}
variable "private_key_path" {
  description = "Path to the private key used for ssh access"
}
