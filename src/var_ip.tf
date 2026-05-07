variable "ip_address" {
  type        = string
  description = "ip-адрес"
  default     = "192.168.0.1"

  validation {
    condition     = can(cidrhost("${var.ip_address}/32", 0))
    error_message = "IP-адрес некорректный!"
  }
}

variable "ip_addresses_list" {
  type        = list(string)
  description = "список ip-адресов"
  default     = ["192.168.0.1", "1.1.1.1", "127.0.0.1"]

  validation {
    condition     = alltrue([for ip in var.ip_addresses_list : can(cidrhost("${ip}/32", 0))])
    error_message = "Все адреса должны быть корректными!"
  }
}
