# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "ubuntu/trusty64"

  config.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'"
  config.vm.provision "shell", path: "provisioner.sh", privileged: false

  config.vm.hostname = "desman.local"
  config.vm.network :private_network, ip: "192.168.99.7"
  config.vm.network "forwarded_port", guest: 3000, host: 3000
  config.vm.network "forwarded_port", guest: 9200, host: 9200
  config.vm.network "forwarded_port", guest: 5601, host: 5601

  config.vm.provider "virtualbox" do |vb|
    vb.customize ["modifyvm", :id, "--memory", "2048"]
  end
end
