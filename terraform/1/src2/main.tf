terraform {
  required_providers {
    virtualbox = {
      source = "shekeriev/virtualbox"
      version = "0.0.4"
    }
  }
}

provider "virtualbox" {
  delay      = 60
  mintimeout = 5
}

resource "virtualbox_vm" "virtualtest" {
  name   = "testvm"
  image  = "./mybox.box"
  cpus      = 1
  memory    = "1024 mib"
  network_adapter {
    type           = "nat"
    device         = "IntelPro1000MTDesktop"
    host_interface = "vboxnet1"
  }
}

output "IPAddress" {
  value = element(virtualbox_vm.virtualtest.*.network_adapter.0.ipv4_address, 1)
}