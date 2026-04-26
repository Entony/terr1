
data "yandex_compute_image" "ubuntu" {
  family = var.os_family
}

resource "yandex_compute_instance" "web" {
  count       = var.count_web
  name        = "web-${count.index + 1}"
  platform_id = var.platform_id

  resources {

    cores         = var.vm_resources["web"].cores
    memory        = var.vm_resources["web"].memory
    core_fraction = var.vm_resources["web"].core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }

  scheduling_policy {
    preemptible = true
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.develop.id
    nat                = true
    security_group_ids = [yandex_vpc_security_group.example.id]
  }

  metadata = {
    serial-port-enable = var.serial_port
    ssh-keys           = "${var.username}:${file("~/.ssh/id_rsa.pub")}"
  }
}



