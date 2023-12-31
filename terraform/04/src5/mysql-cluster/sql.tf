terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">=0.13"
}


resource "yandex_mdb_mysql_cluster" "cluster" {
  name                = var.cluster_name
  environment         = "PRESTABLE"
  network_id          = var.network_id
  version             = "8.0"

  resources {
    resource_preset_id = "s2.micro"
    disk_type_id       = "network-ssd"
    disk_size          = 16
  }

  mysql_config = {
    sql_mode                      = "ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION"
    max_connections               = 100
    default_authentication_plugin = "MYSQL_NATIVE_PASSWORD"
    innodb_print_all_deadlocks    = true

  }

  #second host if hf ==true
  dynamic "host" {
    for_each = var.ha == true ? {1:"ru-central1-a",2:"ru-central1-a"} : {1:"ru-central1-a"}
    content{
        zone      = host.value
        subnet_id = var.network_id
    }
  }
}

