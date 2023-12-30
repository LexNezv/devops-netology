terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">=0.13"
}


resource "yandex_mdb_mysql_cluster" "<имя_кластера>" {
  name                = "<имя_кластера>"
  environment         = "<окружение>"
  network_id          = "<идентификатор_сети>"
  version             = "<версия_MySQL>"
  security_group_ids  = [ "<список_идентификаторов_групп_безопасности>" ]
  deletion_protection = <защита_от_удаления_кластера>

  resources {
    resource_preset_id = "<класс_хоста>"
    disk_type_id       = "<тип_диска>"
    disk_size          = "<размер_хранилища_ГБ>"
  }

  host {
    zone             = "<зона_доступности>"
    subnet_id        = "<идентификатор_подсети>"
    assign_public_ip = <публичный_доступ_к_хосту>
    priority         = <приоритет_при_выборе_хоста-мастера>
    backup_priority  = <приоритет_для_резервного_копирования>
  }
}

resource "yandex_mdb_mysql_database" "<имя_БД>" {
  cluster_id = "<идентификатор_кластера>"
  name       = "<имя_БД>"
}

resource "yandex_mdb_mysql_user" "<имя_пользователя>" {
  cluster_id = "<идентификатор_кластера>"
  name       = "<имя_пользователя>"
  password   = "<пароль_пользователя>"
  permission {
    database_name = "<имя_БД>"
    roles         = ["ALL"]
  }
}

resource "yandex_vpc_network" "<имя_сети>" { name = "<имя_сети>" }

resource "yandex_vpc_subnet" "<имя_подсети>" {
  name           = "<имя_подсети>"
  zone           = "<зона_доступности>"
  network_id     = "<идентификатор_сети>"
  v4_cidr_blocks = ["<диапазон>"]
}

