###cloud vars
variable "vault_address" {
  type        = string
  default = "127.0.0.1"
}

variable "vault_port" {
  type        = string
  default = "8200"
}

variable "vault_token" {
  type        = string
  default = "education"
}
