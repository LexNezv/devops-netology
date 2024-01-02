provider "vault" {
 address = "http://${var.vault_address}:${var.vault_port}"
 skip_tls_verify = true
 token = var.vault_token
}

data "vault_generic_secret" "vault_example"{
 path = "secret/example"
}

resource "vault_generic_secret" "example_vault" {
  path = "secret/foo"

  data_json = <<EOT
{
  "happy":   "new",
  "year": "!"
}
EOT
}

output "vault_example" {
 value = "${nonsensitive(data.vault_generic_secret.vault_example.data)}"
} 

data "vault_generic_secret" "example_vault_ouput"{
 path = "secret/foo"
}

output "vault_example1" {
 value = "${nonsensitive(data.vault_generic_secret.example_vault_ouput.data)}"
} 

