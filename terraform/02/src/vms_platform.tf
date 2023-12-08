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
      "db" = {
        cores = 2
        memory = 2
        core_fraction = 20
      }
    }
    description = "vm resources"
}
### vm_db_vars

variable "vm_db_core_family" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "choose image for vm"
}


### vm_web_vars

variable "vm_web_core_family" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "choose image for vm"
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