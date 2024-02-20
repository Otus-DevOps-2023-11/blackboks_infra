terraform {
  backend "s3" {
    bucket = "tf-state-files"
    endpoints = {
      s3 = "https://storage.yandexcloud.net/tf-state-files"
    }
    key                         = "prod/terraform.tfstate"
    region                      = "eu-west-2"
    skip_requesting_account_id  = true
    skip_credentials_validation = true
    skip_region_validation      = true
    skip_metadata_api_check     = true
    skip_s3_checksum            = true
  }
}
