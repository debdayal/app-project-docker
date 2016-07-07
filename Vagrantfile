# -*- mode: ruby -*-
# vi: set ft=ruby :

# cluster nodes
hosts = {
  "sun" => "192.168.33.101",
  "mercury" => "192.168.33.102",
  "venus" => "192.168.33.103",
  "earth" => "192.168.33.104",
  "mars" => "192.168.33.105"
}

Vagrant.configure(2) do |config|

  config.vm.box = "ubuntu/trusty64"
  config.vm.box_check_update = false

  hosts.each do |name, ip|
    config.vm.define name do |machine|
      machine.vm.hostname = name
      machine.vm.network "private_network", ip: ip
      machine.vm.provider "virtualbox" do |vb|
        if name != "mercury"
          vb.memory = "2048"
        end
          vb.name = name
        end
      end
    end
 config.vm.synced_folder ".", "/vagrant"
 config.vm.synced_folder "/Users", "/Users"
 config.vm.provision :shell, path: "provision/bootstrap.sh"
 config.vm.provision :shell, inline: 'PYTHONUNBUFFERED=1 ansible-playbook -s /vagrant/provision/ansible/prov.yml -c local'

 if Vagrant.has_plugin?("vagrant-cachier")
   config.cache.scope = :box
 end
end
