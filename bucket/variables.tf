variable "token" {
  type = string
}

variable "cloud_id" {
  type = string
}

variable "folder_id" {
  type = string
}

variable "service_access_key" {
  description = "Access key сервисного аккаунта с ролью storage.admin"
  type        = string
  sensitive   = true
}

variable "service_secret_key" {
  description = "Secret key сервисного аккаунта"
  type        = string
  sensitive   = true
}
