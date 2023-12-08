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
  default     = "ru-central1-b"
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
  description = "VPC network & subnet name"
}


###ssh vars

variable "vms_ssh_root_key" {
  type        = string
  default     = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIC5Y8WONOxPmCuDI1LN/UXHthViZe+inj/uOq7030Ytz"
  description = "ssh-keygen -t ed25519"
}

### vm_web_ vars

variable "vm_web_cores" {
  type        = number
  default     = 2
  description = "number of cores VM"
}

variable "vm_web_memory" {
  type        = number
  default     = 1
  description = "memory of VM"
}

variable "vm_web_core_fraction" {
  type        = number
  default     = 5
  description = "core fraction for vm"
}

variable "vm_web_core_family" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "choose image for vm"
}

