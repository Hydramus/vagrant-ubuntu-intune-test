Vagrant.configure('2') do |config|
  config.vm.box = 'generic/ubuntu2204'
  config.vm.hostname = "ubuntu-intune-test"
  
  # Network configuration to allow the VM to communicate with the internet
  config.vm.network "public_network"

  config.vm.define 'ubuntu_msintune' do |_ubuntu_msintune|
    config.vm.synced_folder '.', '/vagrant', automount: true

    config.vm.provider 'virtualbox' do |vb|
      vb.name = 'Ubuntu Desktop and Microsoft Intune app'
      vb.memory = '8192'
      vb.cpus = '2'
      vb.customize ['modifyvm', :id, '--graphicscontroller', 'vmsvga']
      vb.customize ['modifyvm', :id, '--vram', '16']
      vb.customize ['modifyvm', :id, '--clipboard-mode', 'bidirectional']
      vb.customize ['modifyvm', :id, '--draganddrop', 'bidirectional']
      vb.gui = true
    end

    # Shell provisioning
    config.vm.provision "shell", path: 'scripts/ubuntu_config.sh'
  end
end

