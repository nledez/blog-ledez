---
id: 957
title: Prerequis pour un atelier chef
author: Nicolas Ledez
layout: post
guid: http://blog.ledez.net/?p=957
permalink: /informatique/devops/prerequis-pour-atelier-chef/
hide_post_title:
  - default
unlink_post_title:
  - default
hide_post_meta:
  - default
hide_post_date:
  - default
hide_post_image:
  - default
unlink_post_image:
  - default
builder_switch_frontend:
  - 0
categories:
  - DevOps
tags:
  - chef
  - devops
  - vagrant
---
Tout d&rsquo;abord, je n&rsquo;ai pas grand-chose contre Windows (enfin si, mais ce n&rsquo;est pas le sujet).

Mais pour faire l&rsquo;atelier, vous allez avoir besoin d&rsquo;une ligne de commande pour taper des commandes Ruby, Chef, Vagrant. Donc si vous avez un Windows soit vous vous débrouillez lors de l&rsquo;atelier soit vous serez en binôme.

Installer chef :

J&rsquo;ai déjà Ruby :

{% highlight bash %}
    gem install chef foodcritic chefspec vagrant-wrapper minitest-chef-handler
{% endhighlight %}

Je n&rsquo;ai pas Ruby et je &laquo;&nbsp;n&rsquo;en veux pas&nbsp;&raquo; :  
<http://www.getchef.com/chef/install/>  
<http://docs.opscode.com/install_workstation.html>

Inscrivez-vous sur :  
<https://preview.opscode.com/signup>

Plus d&rsquo;informations sur [la page ici][1].

Installer Virtual Box :  
<https://www.virtualbox.org/wiki/Downloads>

Installer Vagrant :  
<http://www.vagrantup.com/downloads.html>

Créez un fichier &laquo;&nbsp;Vagrantfile&nbsp;&raquo; :

{% highlight bash %}
    vagrant init
{% endhighlight %}

Et remplacez son contenu par :

{% highlight ruby %}
# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.define "ubuntu12" do |ub12|
    ub12.vm.hostname = "ubuntu12"
    ub12.vm.box = "opscode-ubuntu-12.04"
    ub12.vm.box_url = "http://opscode-vm-bento.s3.amazonaws.com/vagrant/virtualbox/opscode_ubuntu-12.04_chef-provisionerless.box"
  end

  config.vm.define "ubuntu10" do |ub10|
    ub10.vm.hostname = "ubuntu10"
    ub10.vm.box = "opscode-ubuntu-10.04"
    ub10.vm.box_url = "http://opscode-vm-bento.s3.amazonaws.com/vagrant/virtualbox/opscode_ubuntu-10.04_chef-provisionerless.box"
  end

  config.vm.provision :chef_solo do |chef|
    chef.json = {
      :mysql => {
        :server_root_password => 'rootpass',
        :server_debian_password => 'debpass',
        :server_repl_password => 'replpass'
      }
    }
  end
end
{% endhighlight %}

Vérifiez que les commandes suivantes fonctionnent :

{% highlight bash %}
vagrant up
vagrant provision
{% endhighlight %}

Bon, c&rsquo;est un peu rapide, mais je n&rsquo;ai pas eu le temps de préparer mieux. Pourtant, j&rsquo;avais plein d&rsquo;idées <img src="https://blog.ledez.net/wp-includes/images/smilies/simple-smile.png" alt=":)" class="wp-smiley" style="height: 1em; max-height: 1em;" />

 [1]: http://blog.ledez.net/informatique/utiliser-chef-1-opscode/ "Utiliser chef #1 – Création d’un compte chez Opscode"
