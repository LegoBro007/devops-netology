terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

provider "yandex" {
  service_account_key_file = "key.json"
  zone = var.yandex_cloud_zone
  folder_id = var.folder_id
  cloud_id = var.yandex_cloud_id
}