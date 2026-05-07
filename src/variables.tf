###cloud vars
# закомментировано из-за дженкинса
# variable "token" {
#   type        = string
#   description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
# }

# variable "cloud_id" {
#   type        = string
#   description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
# }

# variable "folder_id" {
#   type        = string
#   description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
# }

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
# variable "default_cidr" {
#   type        = list(string)
#   default     = ["10.0.1.0/24"]
#   description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
# }

# variable "vpc_name" {
#   type        = string
#   default     = "develop"
#   description = "VPC network&subnet name"
# }

###common vars

# variable "vms_ssh_root_key" {
#   type        = string
#   default     = "your_ssh_ed25519_key"
#   description = "ssh-keygen -t ed25519"
# }

# ###example vm_web var
# variable "vm_web_name" {
#   type        = string
#   default     = "netology-develop-platform-web"
#   description = "example vm_web_ prefix"
# }

# ###example vm_db var
# variable "vm_db_name" {
#   type        = string
#   default     = "netology-develop-platform-db"
#   description = "example vm_db_ prefix"
# }

variable "ssh-key" {
  type    = string
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDf6mYU6+KXfSoxzl7JEHb4ffE2zd0Xk3fcpuvwV2F+QNaQqT8R6rUS4qDtNjc6WrJY+ubxjv1W5F+gKENJ7Dg4AxMrHNXDqT8lc9qzsrdnAQ416eNIHgr11KFWeWN4fffoBAsrs6g8L5UfU+vvSbPe0cLDfNJAI/bY1M4ePc8QBKpgXqn+M2lr2Uut+FKLqo8pqNX+lHunPl4vPgj0LURrXSE/BCQkmzT03aTbbh4D0zmHo2DRIf25W0HFBqFk01SUPSsFGUpoVmJJxOCuPpjek+Y2nQGoVTUztz4SbNh96B5gJAmw0yDgifHW82WuBj/m4+mng4MvtNpVSdMCoMyP"
}

variable "username" {
  type    = string
  default = "ubuntu"
}

variable "packages" {
  type    = string
  default = "nginx"
}



