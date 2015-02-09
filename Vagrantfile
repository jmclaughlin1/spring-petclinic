# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "sls-demo"

  config.vm.network "forwarded_port", guest: 9966, host: 9966

  config.vm.provider "virtualbox" do |v|
    v.name = "spring-petclinic"
    v.customize ["modifyvm", :id, "--memory", 1024]
    v.customize ["modifyvm", :id, "--cpus", 4]
  end

  # config.vm.synced_folder "../data", "/vagrant_data"

  config.vm.provision "chef_solo" do |chef|
     
     chef.add_recipe "java"
     chef.add_recipe "maven"
     chef.add_recipe "petclinic"
     
     chef.json = { 
      "base_folder" => "/vagrant",
      "java" => {
        "install_flavor" => "openjdk",
        "jdk_version" => "7",
        "java_home" => "/usr/lib/jvm/java-7-openjdk-amd64",
        "oracle" => {
          "accept_oracle_download_terms" => true
        }
      },
      "maven" => {
        "version" => "3",
        "install_java" => false
      }
     }
  end

end
