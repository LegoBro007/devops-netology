data "yandex_compute_image" "image" {
  family = "ubuntu-2004-lts"
}
resource "yandex_vpc_network" "test_vpc" {
  name = "test_vpc"
  folder_id = var.folder_id
}
resource "yandex_vpc_subnet" "subnet-test"{
  name = "vpc-subnet-test"
  network_id = yandex_vpc_network.test_vpc.id
  v4_cidr_blocks = ["192.168.0.0/24"]
  zone = "ru-central1-a"
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
    stage = 4
    prod = 8
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
      image_id = data.yandex_compute_image.image.id
      type     = "network-ssd"
      size     = "20"
    }
  }
      network_interface {
      subnet_id = yandex_vpc_subnet.subnet-test.id
    }
}
resource "yandex_compute_instance" "for_each" {
  for_each = local.instance_type_for-each[terraform.workspace]
  lifecycle {
    create_before_destroy = true
  }
  boot_disk {
    initialize_params {
      size        = "20"
      type        = "network-nvme"
      image_id    = data.yandex_compute_image.image.id
    }
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-test.id
  }
  resources {
    cores  = local.cores[terraform.workspace]
    memory = local.memory[terraform.workspace]
  }
}