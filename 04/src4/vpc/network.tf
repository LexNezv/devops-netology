terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">=0.13"
}

# create network
resource "yandex_vpc_network" "vpc" {
  name = var.env_name
}

# create subnet
resource "yandex_vpc_subnet" "subnet" {
  for_each       = {for sub in var.subnets: sub.zone => sub}
  name           = "${var.env_name}-${each.key}"
  zone           = each.value.zone
  network_id     = yandex_vpc_network.vpc.id
  v4_cidr_blocks = [each.value.cidr]
}

