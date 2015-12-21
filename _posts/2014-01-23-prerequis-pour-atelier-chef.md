---
id: 957
title: Prerequis pour un atelier chef
author: Nicolas Ledez
layout:
  - default
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

<div class="codecolorer-container bash default" style="overflow:auto;white-space:nowrap;">
  <div class="bash codecolorer">
    gem <span class="kw2">install</span> chef foodcritic chefspec vagrant-wrapper minitest-chef-handler
  </div>
</div>

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

<div class="codecolorer-container bash default" style="overflow:auto;white-space:nowrap;">
  <div class="bash codecolorer">
    vagrant init
  </div>
</div>

Et remplacez son contenu par :

<div class="codecolorer-container ruby default" style="overflow:auto;white-space:nowrap;">
  <div class="ruby codecolorer">
    <span class="co1"># -*- mode: ruby -*-</span><br /> <span class="co1"># vi: set ft=ruby :</span><br /> <br /> Vagrant.<span class="me1">configure</span><span class="br0">&#40;</span><span class="st0">"2"</span><span class="br0">&#41;</span> <span class="kw1">do</span> <span class="sy0">|</span>config<span class="sy0">|</span><br /> &nbsp; config.<span class="me1">vm</span>.<span class="me1">define</span> <span class="st0">"ubuntu12"</span> <span class="kw1">do</span> <span class="sy0">|</span>ub12<span class="sy0">|</span><br /> &nbsp; &nbsp; ub12.<span class="me1">vm</span>.<span class="me1">hostname</span> = <span class="st0">"ubuntu12"</span><br /> &nbsp; &nbsp; ub12.<span class="me1">vm</span>.<span class="me1">box</span> = <span class="st0">"opscode-ubuntu-12.04"</span><br /> &nbsp; &nbsp; ub12.<span class="me1">vm</span>.<span class="me1">box_url</span> = <span class="st0">"http://opscode-vm-bento.s3.amazonaws.com/vagrant/virtualbox/opscode_ubuntu-12.04_chef-provisionerless.box"</span><br /> &nbsp; <span class="kw1">end</span><br /> <br /> &nbsp; config.<span class="me1">vm</span>.<span class="me1">define</span> <span class="st0">"ubuntu10"</span> <span class="kw1">do</span> <span class="sy0">|</span>ub10<span class="sy0">|</span><br /> &nbsp; &nbsp; ub10.<span class="me1">vm</span>.<span class="me1">hostname</span> = <span class="st0">"ubuntu10"</span><br /> &nbsp; &nbsp; ub10.<span class="me1">vm</span>.<span class="me1">box</span> = <span class="st0">"opscode-ubuntu-10.04"</span><br /> &nbsp; &nbsp; ub10.<span class="me1">vm</span>.<span class="me1">box_url</span> = <span class="st0">"http://opscode-vm-bento.s3.amazonaws.com/vagrant/virtualbox/opscode_ubuntu-10.04_chef-provisionerless.box"</span><br /> &nbsp; <span class="kw1">end</span><br /> <br /> &nbsp; config.<span class="me1">vm</span>.<span class="me1">provision</span> <span class="re3">:chef_solo</span> <span class="kw1">do</span> <span class="sy0">|</span>chef<span class="sy0">|</span><br /> &nbsp; &nbsp; chef.<span class="me1">json</span> = <span class="br0">&#123;</span><br /> &nbsp; &nbsp; &nbsp; <span class="re3">:mysql</span> <span class="sy0">=></span> <span class="br0">&#123;</span><br /> &nbsp; &nbsp; &nbsp; &nbsp; <span class="re3">:server_root_password</span> <span class="sy0">=></span> <span class="st0">'rootpass'</span>,<br /> &nbsp; &nbsp; &nbsp; &nbsp; <span class="re3">:server_debian_password</span> <span class="sy0">=></span> <span class="st0">'debpass'</span>,<br /> &nbsp; &nbsp; &nbsp; &nbsp; <span class="re3">:server_repl_password</span> <span class="sy0">=></span> <span class="st0">'replpass'</span><br /> &nbsp; &nbsp; &nbsp; <span class="br0">&#125;</span><br /> &nbsp; &nbsp; <span class="br0">&#125;</span><br /> &nbsp; <span class="kw1">end</span><br /> <span class="kw1">end</span>
  </div>
</div>

Vérifiez que les commandes suivantes fonctionnent :

<div class="codecolorer-container bash default" style="overflow:auto;white-space:nowrap;">
  <div class="bash codecolorer">
    vagrant up<br /> vagrant provision
  </div>
</div>

Bon, c&rsquo;est un peu rapide, mais je n&rsquo;ai pas eu le temps de préparer mieux. Pourtant, j&rsquo;avais plein d&rsquo;idées <img src="https://blog.ledez.net/wp-includes/images/smilies/simple-smile.png" alt=":)" class="wp-smiley" style="height: 1em; max-height: 1em;" />

 [1]: http://blog.ledez.net/informatique/utiliser-chef-1-opscode/ "Utiliser chef #1 – Création d’un compte chez Opscode"