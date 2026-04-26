###cloud vars
variable "token" {
  type        = string
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
}

variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network&subnet name"
}

# Ресурсы для ВМ web
variable "vm_resources" {
  type = map(object({
    cores         = number
    memory        = number
    core_fraction = number
    name          = string
  }))
  description = "Ресурсы для каждой ВМ"

  default = {
    web = {
      cores         = 2
      memory        = 1
      core_fraction = 5
      name          = null
    }
    storage = {
      cores         = 2
      memory        = 1
      core_fraction = 5
      name          = "storage"
    }
  }
}

variable "platform_id" {
  type    = string
  default = "standard-v2"
}

# Количество ВМ для web
variable "count_web" {
  type    = number
  default = 2
}

variable "os_family" {
  type    = string
  default = "ubuntu-2004-lts"
}

#Ресурсы для db

variable "each_vm" {
  type = list(object({
    name          = string,
    cpu           = number,
    ram           = number,
    core_fraction = number,
  disk_volume = number }))

  default = [
    {
      name          = "main"
      cpu           = 4
      ram           = 4
      core_fraction = 20
      disk_volume   = 10
    },
    {
      name          = "replica"
      cpu           = 2
      ram           = 2
      core_fraction = 5
      disk_volume   = 5
  }]
}

# Имя пользователя ВМ
variable "username" {
  type    = string
  default = "ubuntu"
}

# Необходимо для metadata
variable "serial_port" {
  type    = number
  default = 1
}

# Количество дисков для задания 3
variable "count_disk" {
  type    = number
  default = 3
}

# Размер дополнительных дисков для задания 3
variable "disk_size" {
  type    = number
  default = 1
}






