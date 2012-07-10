Vagrant::Config.run do |config|
  config.vm.box = "precise64"
  config.vm.box_url = "http://files.vagrantup.com/precise64.box"
  config.vm.network :hostonly, "192.168.33.11"
  config.vm.customize ["modifyvm", :id, "--memory", 2048]
end
