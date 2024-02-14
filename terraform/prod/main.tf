terraform {
  required_version = ">= 0.13.0"
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "~> 0.35.0"
    }
  }
}

provider "yandex" {
  service_account_key_file = var.service_account_key_file
  cloud_id                 = var.cloud_id
  folder_id                = var.folder_id
  zone                     = var.zone
}
module "app" {
  source           = "../modules/app"
  public_key_path  = var.public_key_path
  app_disk_image   = var.app_disk_image
  subnet_id        = var.subnet_id
  app_name         = var.app_name
  private_key_path = var.private_key_path
}

module "db" {
  source           = "../modules/db"
  public_key_path  = var.public_key_path
  db_disk_image    = var.db_disk_image
  subnet_id        = var.subnet_id
  db_name          = var.db_name
  private_key_path = var.private_key_path
}

# resource "yandex_storage_bucket" "prod" {
#   access_key = "YCAJEAmejDzga2rhROakPI6z3"
#   secret_key = "YCOa587ndli2mNbRASed6MkwTeKn2r3K6NRS5Tmk"
#   bucket     = "state-prod"
# }

resource "yandex_storage_bucket" "tf-bucket" {
  access_key = "YCAJEAmejDzga2rhROakPI6z3"
  secret_key = "YCOa587ndli2mNbRASed6MkwTeKn2r3K6NRS5Tmk"
  bucket     = "tf-state-files"
}
