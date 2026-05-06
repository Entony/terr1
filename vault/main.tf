terraform {
  required_providers {
    vault = {
      source  = "hashicorp/vault"
      version = "~> 3.0"
    }
  }
}

provider "vault" {
  address         = "http://127.0.0.1:8200"
  skip_tls_verify = true
  token           = "education"
}

data "vault_generic_secret" "vault_example" {
  path = "secret/example"
}

output "vault_example" {
  value = nonsensitive(data.vault_generic_secret.vault_example.data)
}

# Создание нового секрета

resource "vault_generic_secret" "new_secret" {
  path = "secret/terraform_managed"

  data_json = jsonencode({
    username = "netology",
    password = "12345"
  })
}

