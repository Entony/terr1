variable "net_name" {
  type = string
}

# variable "zone" {
#   type = string
# }

# variable "cidr" {
#   type = string
# }

# Задание 4
variable "subnets" {
  type = list(object({
    zone = string
    cidr = string
  }))
}
