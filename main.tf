provider "vsphere" {
  user                 = var.vsphere_user
  password             = var.vsphere_password
  vsphere_server       = var.vsphere_server
  allow_unverified_ssl = true
}
data "vsphere_datacenter" "dc" {
  name = "dc1"
}
data "vsphere_resource_pool" "pool" {
  name          = "cluster1/Resources"
  datacenter_id = data.vsphere_datacenter.dc.id
}
data "vsphere_datastore" "datastore" {
  name          = "datastore1"
  datacenter_id = data.vsphere_datacenter.dc.id
}
data "vsphere_network" "network" {
  name          = "Vlan-210"
  datacenter_id = data.vsphere_datacenter.dc.id
}
resource "vsphere_virtual_machine" "vm" {
  name             = "ubuntu_teste"
  resource_pool_id = data.vsphere_resource_pool.pool.id

  num_cpus = 2
  memory   = 1024
  datastore_id = "612c7d16-d38cf8b4-2251-002590c5eeb4"
  guest_id = "other3xLinux64Guest"  
  network_interface {
    network_id = data.vsphere_network.network.id
  }
   disk {
    label = "disk0"
    size  = 20    
  }
}

