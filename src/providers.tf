terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "~> 0.95"
    }
    template = {
      source  = "hashicorp/template"
      version = "~> 2.2.0" # Укажите актуальную версию
    }
  }
  required_version = "~>1.13.0"

  backend "s3" {
    bucket = "my-bucket06052026"
    key    = "terraform.tfstate"
    region = "ru-central1"

    # Встроенный механизм блокировок (Terraform >= 1.6)
    # Не требует отдельной базы данных!
    use_lockfile = true

    endpoints = {
      s3 = "https://storage.yandexcloud.net"
    }

    skip_region_validation      = true
    skip_credentials_validation = true
    skip_requesting_account_id  = true
    skip_s3_checksum            = true
  }

}

# provider "aws" {
#   skip_region_validation      = true
#   skip_credentials_validation = true
#   skip_requesting_account_id  = true

#   access_key = var.service_access_key
#   secret_key = var.service_secret_key
#   region     = "ru-central1"
#   endpoints {
#     s3 = "https://storage.yandexcloud.net"
#   }
# }

provider "yandex" {
  token     = var.token
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  zone      = var.default_zone
}



