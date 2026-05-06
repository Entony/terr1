#resource "yandex_vpc_network" "develop" {
#   name = var.vpc_name
# }
# resource "yandex_vpc_subnet" "develop" {
#   name           = var.vpc_name
#   zone           = var.default_zone
#   network_id     = yandex_vpc_network.develop.id
#   v4_cidr_blocks = var.default_cidr
# }


# Задание 3
# module "module_network" {
#   source   = "./module_network"
#   net_name = "vpc_dev"
#   zone     = var.default_zone
#   cidr     = var.default_cidr[0]
# }

#Задание 4

data "terraform_remote_state" "vpc" {
  backend = "local"

  config = {
    path = "../vpc/terraform.tfstate"
  }
}

module "marketing-vm" {
  source   = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
  env_name = "netology"

  # Задание2
  # network_id     = yandex_vpc_network.develop.id
  # subnet_zones   = [var.default_zone]
  # subnet_ids     = [yandex_vpc_subnet.develop.id]

  # Задание 3
  #network_id = module.module_network.subnet.network_id
  #subnet_zones = [module.module_network.subnet.zone]
  #subnet_ids     = [module.module_network.subnet.id]

  # Задание 4
  network_id   = data.terraform_remote_state.vpc.outputs.network_subnets["ru-central1-a"].network_id
  subnet_ids   = [data.terraform_remote_state.vpc.outputs.network_subnets["ru-central1-a"].id]
  subnet_zones = ["ru-central1-a"]



  instance_name  = "marketing"
  instance_count = 1
  image_family   = "ubuntu-2004-lts"
  public_ip      = true

  labels = {
    project = "marketing"
  }

  metadata = {
    user-data          = data.template_file.cloudinit.rendered #Для демонстрации №3
    serial-port-enable = 1
  }

}

module "analytics-vm" {
  source   = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
  env_name = "netology"

  # Задание 2
  # network_id     = yandex_vpc_network.develop.id
  # subnet_zones   = [var.default_zone]
  # subnet_ids     = [yandex_vpc_subnet.develop.id]

  # Задание 3
  # network_id = module.module_network.subnet.network_id
  # subnet_zones = [module.module_network.subnet.zone]
  # subnet_ids     = [module.module_network.subnet.id]

  # Задание 4

  network_id   = data.terraform_remote_state.vpc.outputs.network_subnets["ru-central1-b"].network_id
  subnet_ids   = [data.terraform_remote_state.vpc.outputs.network_subnets["ru-central1-b"].id]
  subnet_zones = ["ru-central1-b"]

  instance_name  = "analytics"
  instance_count = 1
  image_family   = "ubuntu-2004-lts"
  public_ip      = true

  labels = {
    project = "analytics"
  }

  metadata = {
    user-data          = data.template_file.cloudinit.rendered #Для демонстрации №3
    serial-port-enable = 1
  }

}

#Пример передачи cloud-config в ВМ для демонстрации №3
data "template_file" "cloudinit" {
  template = file("./cloud-init.yml")
  vars = {
    ssh_public_key = var.ssh-key
    username       = var.username
    packages       = var.packages
  }
}

