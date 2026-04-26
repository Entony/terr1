
resource "yandex_compute_instance" "db" {
  for_each    = { for vm in var.each_vm : vm.name => vm }
  name        = each.value.name
  platform_id = var.platform_id

  resources {

    cores         = each.value.cpu
    memory        = each.value.ram
    core_fraction = each.value.core_fraction
  }

  boot_disk {
    initialize_params {
      size     = each.value.disk_volume
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

  depends_on = [yandex_compute_instance.web]
}




