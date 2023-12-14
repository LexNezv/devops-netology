resource "yandex_compute_disk" "disks" {
  count = 3
  name     = "disk-${count.index}"
  type     = var.disks[0].type
  zone     = var.default_zone
  size     = var.disks[0].size
  image_id = data.yandex_compute_image.ubuntu.image_id

  labels = {
    environment = "test"
  }
}

resource "yandex_compute_instance" "storage" {
  name = "storage"
  platform_id = "standard-v1"
  resources {
    cores         = var.vms_resources.storage.cores
    memory        = var.vms_resources.storage.memory
    core_fraction = var.vms_resources.storage.core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }
  dynamic "secondary_disk" {
    for_each = yandex_compute_disk.disks.*.id
    content {
        disk_id = secondary_disk.value
    }
  }

  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
    security_group_ids = [yandex_vpc_security_group.example.id]
  }

  metadata = {
    serial-port-enable = var.metadata.serial-port-enable
    ssh-keys           = "ubuntu:${local.ssh_public_key}"
  }

  
}