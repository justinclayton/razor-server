# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "chef/centos-6.5"
  config.vm.network "forwarded_port", guest: 8080, host: 6680

  config.vm.provider :virtualbox do |vb|
      vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
  end

  #config.vm.synced_folder ".", "/docker-build-razor-server"

  $puppet_setup = <<PUPPET
    echo "Setting up puppet environment..."
    if [ ! -e /etc/yum.repos.d/puppetlabs.repo ]; then rpm -Uvh http://yum.puppetlabs.com/puppetlabs-release-el-6.noarch.rpm; fi
    if [ ! -e /etc/puppet/puppet.conf ]; then yum -y install puppet; fi
    puppet module install garethr/docker
PUPPET

  config.vm.provision "shell" do |puppet|
    puppet.inline = $puppet_setup
  end

  # Enable provisioning with Puppet stand alone.  Puppet manifests
  # are contained in a directory path relative to this Vagrantfile.
  # You will need to create the manifests directory and a manifest in
  # the file default.pp in the manifests_path directory.
  #
  #config.vm.provision "puppet" do |puppet|
  #  puppet.manifests_path = "manifests"
  #  puppet.manifest_file  = "razor-server.pp"
  #  puppet.options = "--verbose"
  #end

end
