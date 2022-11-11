NUM_MASTER_NODES=3
NUM_WORKER_NODES=3
IP_NW="192.168.56."
IP_MASTER_START=100
IP_WORKER_START=200

Vagrant.configure("2") do |config|
  config.vm.provision "shell", inline: <<-SHELL
    sed -i '/#{IP_NW}/d' /etc/hosts
    sed -i '/^[0-9]\s/d' /etc/hosts
  SHELL

  (1..NUM_MASTER_NODES).each do |i|
    config.vm.provision "shell", inline: <<-SHELL
      echo "#{IP_NW}$((#{IP_MASTER_START}+#{i}))  master0#{i}" >> /etc/hosts
    SHELL
  end

  (1..NUM_WORKER_NODES).each do |i|
    config.vm.provision "shell", inline: <<-SHELL
      echo "#{IP_NW}$((#{IP_WORKER_START}+#{i}))  worker0#{i}" >> /etc/hosts
    SHELL
  end

  config.vm.box = "centos/8"
  config.vm.box_check_update = true

  (1..NUM_MASTER_NODES).each do |i|
    config.vm.define "master0#{i}" do |master|
      master.vm.hostname = "master0#{i}"
      master.vm.network "private_network", ip: IP_NW + "#{IP_MASTER_START + i}"

      master.vm.provider "virtualbox" do |vb|
          vb.memory = 2048
          vb.cpus = 2
          vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      end

      master.vm.provision "shell", path: "scripts/common.sh"
    end
  end

  (1..NUM_WORKER_NODES).each do |i|
    config.vm.define "worker0#{i}" do |worker|
      worker.vm.hostname = "worker0#{i}"
      worker.vm.network "private_network", ip: IP_NW + "#{IP_WORKER_START + i}"

      worker.vm.provider "virtualbox" do |vb|
          vb.memory = 2048
          vb.cpus = 2
          vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      end

      worker.vm.provision "shell", path: "scripts/common.sh"
    end
  end
  
  end
