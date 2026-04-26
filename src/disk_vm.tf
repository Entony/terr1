resource "yandex_compute_disk" "vm_disk" {
  count = var.count_disk
  name  = "disk-${count.index + 1}"
  size  = var.disk_size
}

resource "yandex_compute_instance" "storage" {
  name        = var.vm_resources["storage"].name
  platform_id = var.platform_id

  resources {
    cores         = var.vm_resources["storage"].cores
    memory        = var.vm_resources["storage"].memory
    core_fraction = var.vm_resources["storage"].core_fraction
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

  dynamic "secondary_disk" {
    for_each = yandex_compute_disk.vm_disk[*].id

    content {
      disk_id = secondary_disk.value
    }
  }
}


