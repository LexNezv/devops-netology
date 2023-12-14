### vm all vars

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
      core_fraction = 10
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

### vm_web_vars

variable "vm_core_family" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "choose image for vm"
}

data "yandex_compute_image" "ubuntu" {
  family = var.vm_core_family
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