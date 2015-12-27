---
id: 495
title: 'Vagrant tips #1'
author: Nicolas Ledez
layout: post
guid: http://blog.ledez.net/?p=495
permalink: /informatique/vagrant-tips-1/
categories:
  - Informatique
  - OpenSource
  - Ruby
  - Tips
tags:
  - chef
  - provisioning
  - puppet
  - tips
  - vagrant
excerpt_separator: <!--more-->
---
Lors du [Breizhcamp][1], j&rsquo;ai présenté dans ma démonstration comment tuner un peu les VM.

<!--more-->

{% highlight ruby %}
# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant::Config.run do |config|
  config.vm.share_folder "apt-cache", "/var/cache/apt/archives", "../sources/apt-cache"
  config.vm.share_folder "gem-cache", "/usr/local/lib/ruby/gems/1.9.1/cache", "../sources/gem-cache"
  config.vm.share_folder "gem-cache-1.8", "/opt/ruby/lib/ruby/gems/1.8/cache", "../sources/gem-cache"

  config.vm.define :script do |app_config|
    app_config.vm.customize ["modifyvm", :id, "--name", "script", "--memory", "256"]
    app_config.vm.box = "lucid64"
    app_config.vm.host_name = "script"
    app_config.vm.forward_port 22, 2222, :auto => true
    app_config.vm.forward_port 80, 4567
    # app_config.vm.network :hostonly, "33.33.13.37"
    # config.vm.boot_mode = :gui

    app_config.vm.provision :shell, :path => "script-install-proxy.sh"
  end

  config.vm.define :chef do |app_config|
    app_config.vm.customize ["modifyvm", :id, "--name", "script", "--memory", "256"]
    app_config.vm.box = "chef"
    app_config.vm.host_name = "chef"
    app_config.vm.forward_port 22, 2222, :auto => true

    # sudo apt-get install chef
    app_config.vm.provision :chef_solo do |chef|
      chef.cookbooks_path = "cookbooks"
      chef.add_recipe("nginx")
    end
  end

  config.vm.define :puppet do |app_config|
    app_config.vm.customize ["modifyvm", :id, "--name", "script", "--memory", "256"]
    app_config.vm.box = "puppet"
    app_config.vm.host_name = "puppet"
    app_config.vm.forward_port 22, 2222, :auto => true

    # sudo vi /etc/puppet/puppet.conf
    # sudo apt-get install puppet-common
    app_config.vm.provision :puppet do |puppet|
      puppet.manifests_path = "manifests"
    end
  end
end
{% endhighlight %}

Avec tout ça, vous avez 3 VM avec du provisioning :

  * avec un script
  * chef
  * puppet

Du cache local (au niveau de votre machine hôte) pour APT et Gems, que vous pouvez adapter pour vos besoins.

La suite au prochain épisode&#8230;

 [1]: http://breizhcamp.org/ "Breizhcamp"
