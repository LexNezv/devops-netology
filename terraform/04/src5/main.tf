terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">=0.13"
}

provider "yandex" {
  token     = var.token
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  zone      = var.default_zone
}

#enable module
module "vpc_test" {
  source       = "./vpc"
  zone = "ru-central1-a"
  cidr = "10.0.1.0/24"
  env_name = "test"
}

#enable module
module "mysql-cluster" {
  source       = "./mysql-cluster"
  ha       = false
  cluster_name = "example"
  network_id = module.vpc_test.subnet_id
}

#enable module
module "mysql-db" {
  source       = "./mysql-db"
  db_username       = "app"
  db_name = "test"
  cluster_id = module.mysql-cluster.cluster_id
}


