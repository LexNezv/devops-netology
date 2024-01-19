variable "low_string" {
  type        = string
  description = "любая строка"
  default = "STrjng"
  validation {
    condition     = can(regex("^[^A-Z]*$", var.low_string))
    error_message = "only lower case"
  }
}
