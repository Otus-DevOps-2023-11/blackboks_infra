variable "cloud_id" {
  description = "Cloud"
}
variable "folder_id" {
  description = "Folder"
}
variable "zone" {
  description = "Zone"
  # Значение по умолчанию
  default = "ru-central1-a"
}
variable "region_id" {
  description = "Region"
}
variable "public_key_path" {
  # Описание переменной
  description = "Path to the public key used for ssh access"
}
variable "image_id" {
  description = "Disk image"
}
variable "subnet_id" {
  description = "Subnet"
}
variable "service_account_key_file" {
  description = "key.json"
}
variable "yandex_compute_instance_zone" {
  description = "Zone"
  default     = "ru-central1-a"
}
variable "private_key_path" {
  description = "Path to the private key for provisioners"
}
variable "number_of_instances" {
  description = "Number of instances to create"
  default     = "2"
}
variable "app_disk_image" {
  description = "Disk image for reddit app"
  default     = "fd80pap0ro1dfp3v8mdk"
}
variable "db_disk_image" {
  description = "Disk image for reddit db"
  default     = "fd8rl2902l5hl5pdhojn"
}
variable "app_name" {
  description = "Application instance name"
}
variable "db_name" {
  description = "Database instance name"
}
