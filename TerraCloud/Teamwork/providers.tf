terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

module "vpc" {
  source  = "hamnsk/vpc/yandex"
  version = "0.5.0"
  # insert the 1 required variable here
  name    = "vpc_test"
}