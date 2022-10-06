resource "yandex_vpc_network" "network-test"{
  name = "vpc-network-test"
}

resource "yandex_vpc_subnet" "subnet-test"{
  name = "vpc-subnet-test"
  network_id = "${yandex_vpc_network.network-test.id}"
  v4_cidr_blocks = ["192.168.0.0/24"]
  zone = "ru-central1-a"
}

resource "yandex_compute_instance" "node01" {
  name        = "node01"
  platform_id = "standard-v1"
  zone        = "ru-central1-a"
  hostname    = "node01.netologytest.internal"

  resources {
    cores  = 2
    memory = 4
  }
  boot_disk {
    initialize_params {
      name        = "primary-disk"
      description = "first-test-disk"
      size        = "20"
      type        = "network-nvme"
    }
  }

  network_interface {
    subnet_id = "${yandex_vpc_subnet.subnet-test.id}"
  }
}