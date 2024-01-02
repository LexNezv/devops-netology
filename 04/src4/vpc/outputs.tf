output "network_id" {
  value = yandex_vpc_network.vpc.id
  }
output "subnet_id" {
  value = yandex_vpc_subnet.subnet["ru-central1-a"].id
  }
output "vpc_subnet" {
  value = yandex_vpc_subnet.subnet[*]
  }