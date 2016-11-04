ENV["LC_ALL"] = "en_US.UTF-8"

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/trusty64"
  config.vm.hostname = "wasbox"

  config.vm.network "forwarded_port", guest: 9060, host: 9060, auto_correct: true
  config.vm.network "forwarded_port", guest: 9043, host: 9043, auto_correct: true
  config.vm.network "forwarded_port", guest: 9080, host: 9080, auto_correct: true
  config.vm.network "forwarded_port", guest: 9443, host: 9443, auto_correct: true
  # config.vm.network "forwarded_port", guest: 2809, host: 2809, auto_correct: true
  # config.vm.network "forwarded_port", guest: 8880, host: 8880, auto_correct: true

  config.vm.provider "virtualbox" do |vb|
    vb.name = "wasbox"
    vb.memory = "1024"
    vb.cpus = 2
    vb.customize ["modifyvm", :id, "--cpuexecutioncap", "80"]
    vb.customize ["modifyvm", :id, "--paravirtprovider", "kvm"]
  end

  config.vm.synced_folder "~/Downloads/WAS_8.5.5", "/dist", mount_options: ["ro"]

  config.vm.provision "install_was", type: "shell", path: "install_was855.sh"
  config.vm.provision "start_was", type: "shell", run: "always",
    inline: "sudo /opt/IBM/WebSphere/AppServer/bin/startServer.sh server1;"
end
