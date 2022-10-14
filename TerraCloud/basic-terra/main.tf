resource "yandex_vpc_network" "test_vpc" {
  name = "test_vpc"
  folder_id = var.folder_id
}
data "yandex_compute_image" "image_id" {
  family = "ubuntu-2004-lts"
}
locals {
  instance_type_count = {
    stage = 1
    prod  = 2
  }
  cores = {
    stage = 4
    prod = 4
  }
  memory = {
    stage = 2
    prod = 4
  }
  zone = {
    stage = var.yandex_cloud_zone
    prod = var.yandex_cloud_zone
  }
  instance_type_for-each = {
    stage = toset(["node01","node02"]),
    prod  = toset(["node01", "node02", "node03"])
  }

}
  resource yandex_compute_instance "count_vm" {
    count = local.instance_type_count[terraform.workspace]
    resources {
      cores  = local.cores[terraform.workspace]
      memory = local.memory[terraform.workspace]
    }
    boot_disk {
      initialize_params {
        image_id = "image_id"
      }
    }
    network_interface {
      subnet_id = ""
    }
  }
resource "yandex_compute_instance" "for_each" {
  for_each = local.instance_type_for-each[terraform.workspace]
  lifecycle {
    create_before_destroy = true
  }
  boot_disk {
    initialize_params {
      image_id = "image_id"
    }
  }
  network_interface {
    subnet_id = ""
  }
  resources {
    cores  = local.cores[terraform.workspace]
    memory = local.memory[terraform.workspace]
  }
}