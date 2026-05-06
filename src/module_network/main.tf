resource "yandex_vpc_network" "network" {
  name = var.net_name
}

# Задание 3
# resource "yandex_vpc_subnet" "network" {
#   name           = "${var.net_name}-subnet"
#   zone           = var.zone
#   network_id     = yandex_vpc_network.network.id
#   v4_cidr_blocks = [var.cidr]
# }

# Задание 4
resource "yandex_vpc_subnet" "network" {
  for_each = { for s in var.subnets : s.zone => s }

  name           = "${var.net_name}-subnet-${each.value.zone}"
  zone           = each.value.zone
  network_id     = yandex_vpc_network.network.id
  v4_cidr_blocks = [each.value.cidr]
}

