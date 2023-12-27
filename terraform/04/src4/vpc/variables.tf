variable "env_name" {
  type    = string
  description = "Cloud network name"
}

#object with zones and cirdrs
variable "subnets" {
   type = list(object({
    zone = string,
    cidr = string
    }))
  default     = []
}

