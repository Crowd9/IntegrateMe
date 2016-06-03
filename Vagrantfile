# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure(2) do |config|
  config.vm.box = 'ubuntu/trusty64'

  config.vm.network 'forwarded_port', guest: 3000, host: 3000

  config.ssh.forward_agent = true

  config.vm.provision :file, source: '~/.gitconfig', destination: '~/.gitconfig'

  config.vm.provision :shell, path: 'bin/install-deps.sh', privileged: true
  config.vm.provision :shell, path: 'bin/install-bashprofile.sh', privileged: false
end
