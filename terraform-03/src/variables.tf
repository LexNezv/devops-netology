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

### vms res vars vars

variable "vms_resources" {
    type = map(object({
        cores = number
        memory = number
        core_fraction = number
    }))
    default = {
      "web" = {
        cores = 2
        memory = 1
        core_fraction = 5
      },
      "storage" = {
        cores = 2
        memory = 1
        core_fraction = 5
      }
    }
    description = "vm resources"
}

### vm_db_vars

variable "each_vm" {
  type = list(object({  vm_name=string, cpu=number, ram=number, disk=number, core_fraction=number }))
  default = [
    {
      vm_name = "main"
      cpu = 2
      ram = 4
      disk = 20
      core_fraction = 20
    },
        {
      vm_name = "replica"
      cpu = 2
      ram = 4
      disk = 20
      core_fraction = 5
    }
  ]
}

### vm_all_vars

variable "vm_core_family" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "choose image for vm"
}

data "yandex_compute_image" "ubuntu" {
  family = var.vm_core_family
}


### disk vars

variable "disks" {
  type = list(object({ type=string, size=number }))
  default = [
    {
      type    = "network-hdd"
      size    = 5
    }
  ] 
}

### metadata

variable "metadata" {
    type = object({
        serial-port-enable = number
        ssh-keys = string
    })
    default = {
      serial-port-enable = 1
      ssh-keys = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIC5Y8WONOxPmCuDI1LN/UXHthViZe+inj/uOq7030Ytz"
    }
    description = "metadata"
}