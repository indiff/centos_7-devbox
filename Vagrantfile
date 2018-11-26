Vagrant.configure("2") do |config|
    config.vm.box = "centos/7"
    config.vm.provision :shell, :path => "scripts/setup.sh"
    config.vm.network :forwarded_port, host: 8080, guest: 8080
    config.vm.network :forwarded_port, host: 9000, guest: 9000
    config.vm.network :forwarded_port, host: 8091, guest: 8091
    config.vm.network :forwarded_port, host: 61616, guest: 61616
    config.vm.network :forwarded_port, host: 631, guest: 631
    config.vm.network :forwarded_port, host: 5050, guest: 5050
    config.vm.network :forwarded_port, host: 4343, guest: 4343
    config.vm.network :forwarded_port, host: 3306, guest: 3306
    config.ssh.insert_key = true
    config.vm.synced_folder '.', '/vagrant', disabled: true

    config.vm.provider :virtualbox do |vb|
        vb.gui = true
        # Use VBoxManage to customize the VM. For example to change memory:
        vb.customize ["modifyvm", :id, "--name", "centos_7-devbox"]
        vb.customize ["modifyvm", :id, "--memory", "8192"]
        vb.customize ["modifyvm", :id, "--vram", 64]
        vb.customize ["modifyvm", :id, "--cpus", 2]
        vb.customize ["modifyvm", :id, "--accelerate3d", "on"]
        vb.customize ['modifyvm', :id, '--clipboard', 'bidirectional']
        vb.customize ['modifyvm', :id, '--draganddrop', 'bidirectional']
    end
end
