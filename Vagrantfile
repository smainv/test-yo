# -*- mode: ruby -*-
# vi: set ft=ruby :

VM_NAME="testwebsrv"
add_disk='provisioning/vm_disk.vdi'

Vagrant.configure(2) do |config|
  config.vm.box = "trusty32"
  config.vm.box_url = "https://cloud-images.ubuntu.com/vagrant/trusty/current/trusty-server-cloudimg-i386-vagrant-disk1.box"
  config.vm.hostname = VM_NAME
  config.ssh.insert_key = false
  config.ssh.private_key_path = ['~/.vagrant.d/insecure_private_key', '~/.ssh/id_rsa']
  config.vm.network "forwarded_port", guest: 80, host: 8080

  config.vm.synced_folder(".", "/vagrant",
    :owner => "vagrant",
    :group => "vagrant",
    :mount_options => ['dmode=777','fmode=777']
  )
	
  config.vm.provider "virtualbox" do |vb|
  # Create the second disk
    vb.customize ['createhd', '--filename', add_disk, '--size', 2 * 1024]
    vb.customize ['storageattach', :id, '--storagectl', 'SATAController', '--port', 1, '--device', 0, '--type', 'hdd', '--medium', add_disk]
  end
    
  config.vm.provision "shell" do |sh|
    sh.inline = "sudo /vagrant/provisioning/bootstrap.sh"
  end

  config.vm.provision "ansible" do |ansible|
    ansible.groups = {
      "localhost" => ["default"]
    }
    ansible.playbook = "provisioning/webserver.yml"
    ansible.sudo = true
  end
end

