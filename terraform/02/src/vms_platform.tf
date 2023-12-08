### vm_db_vars

variable "vm_db_cores" {
  type        = number
  default     = 2
  description = "number of cores VM"
}

variable "vm_db_memory" {
  type        = number
  default     = 2
  description = "memory of VM"
}

variable "vm_db_core_fraction" {
  type        = number
  default     = 20
  description = "core fraction for vm"
}

variable "vm_db_core_family" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "choose image for vm"
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
