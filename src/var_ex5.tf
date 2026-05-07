variable "low" {
  type        = string
  description = "любая строка"
  default     = "hello_world"

  validation {
    condition     = var.low == lower(var.low)
    error_message = "Строка не должна содержать символы верхнего регистра!"
  }
}

variable "in_the_end_there_can_be_only_one" {
  description = "Who is better Connor or Duncan?"
  type = object({
    Dunkan = optional(bool)
    Connor = optional(bool)
  })

  default = {
    Dunkan = true
    Connor = false
  }

  validation {
    error_message = "There can be only one MacLeod"
    condition     = var.in_the_end_there_can_be_only_one.Dunkan != var.in_the_end_there_can_be_only_one.Connor
  }
}
