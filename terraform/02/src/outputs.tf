output "vm_external_ip_address_db" {
 value = yandex_compute_instance.db.network_interface[0].nat_ip_address
 description = "vm external ip netology-develop-platform-db"
}

output "vm_external_ip_address_web" {
 value = yandex_compute_instance.platform.network_interface[0].nat_ip_address
 description = "netology-develop-platform-web"
}