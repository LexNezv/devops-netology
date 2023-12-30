variable "ha" {
  type    = bool
  description = "hosts > 1"
}

variable "cluster_name" {
  type    = string
  description = "name of cluster"
}

variable "network_id" {
  type    = string
  description = "network id"
}

variable "hosts"{
  type = list(string)
  default = ["name1","name2"]
}
