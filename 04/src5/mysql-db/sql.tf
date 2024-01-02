terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">=0.13"
}

resource "yandex_mdb_mysql_database" "database" {
  cluster_id = var.cluster_id
  name       = var.db_name
}

resource "yandex_mdb_mysql_user" "user" {
    cluster_id = var.cluster_id
    name       = var.db_username
    password   = "password"

    permission {
      database_name = yandex_mdb_mysql_database.database.name
      roles         = ["ALL"]
    }
}



