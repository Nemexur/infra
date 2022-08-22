# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "geerlingguy/ubuntu1804"
  config.vm.synced_folder '.', '/vagrant', disabled: true
  config.ssh.insert_key = false

  config.vm.provider :virtualbox do |v|
    v.memory = 4096
    v.cpus = 2
    v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    v.customize ["modifyvm", :id, "--ioapic", "on"]
  end

  config.vm.define "home" do |home|
    home.vm.hostname = "home.test"
    home.vm.network :private_network, ip: "192.168.56.10"
  end

  config.vm.define "vpn" do |vpn|
    vpn.vm.hostname = "vpn.test"
    vpn.vm.network :private_network, ip: "192.168.56.11"
  end

  config.vm.define "monitoring" do |monitoring|
    monitoring.vm.hostname = "monitoring.test"
    monitoring.vm.network :private_network, ip: "192.168.56.12"
  end
end
