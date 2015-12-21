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
---
Lors du [Breizhcamp][1], j&rsquo;ai présenté dans ma démonstration comment tuner un peu les VM.

<!--more-->

<div class="codecolorer-container ruby default" style="overflow:auto;white-space:nowrap;">
  <div class="ruby codecolorer">
    <span class="co1"># -*- mode: ruby -*-</span><br /> <span class="co1"># vi: set ft=ruby :</span><br /> <br /> <span class="re2">Vagrant::Config</span>.<span class="me1">run</span> <span class="kw1">do</span> <span class="sy0">|</span>config<span class="sy0">|</span><br /> &nbsp; config.<span class="me1">vm</span>.<span class="me1">share_folder</span> <span class="st0">"apt-cache"</span>, <span class="st0">"/var/cache/apt/archives"</span>, <span class="st0">"../sources/apt-cache"</span><br /> &nbsp; config.<span class="me1">vm</span>.<span class="me1">share_folder</span> <span class="st0">"gem-cache"</span>, <span class="st0">"/usr/local/lib/ruby/gems/1.9.1/cache"</span>, <span class="st0">"../sources/gem-cache"</span><br /> &nbsp; config.<span class="me1">vm</span>.<span class="me1">share_folder</span> <span class="st0">"gem-cache-1.8"</span>, <span class="st0">"/opt/ruby/lib/ruby/gems/1.8/cache"</span>, <span class="st0">"../sources/gem-cache"</span><br /> <br /> &nbsp; config.<span class="me1">vm</span>.<span class="me1">define</span> <span class="re3">:script</span> <span class="kw1">do</span> <span class="sy0">|</span>app_config<span class="sy0">|</span><br /> &nbsp; &nbsp; app_config.<span class="me1">vm</span>.<span class="me1">customize</span> <span class="br0">&#91;</span><span class="st0">"modifyvm"</span>, <span class="re3">:id</span>, <span class="st0">"--name"</span>, <span class="st0">"script"</span>, <span class="st0">"--memory"</span>, <span class="st0">"256"</span><span class="br0">&#93;</span><br /> &nbsp; &nbsp; app_config.<span class="me1">vm</span>.<span class="me1">box</span> = <span class="st0">"lucid64"</span><br /> &nbsp; &nbsp; app_config.<span class="me1">vm</span>.<span class="me1">host_name</span> = <span class="st0">"script"</span><br /> &nbsp; &nbsp; app_config.<span class="me1">vm</span>.<span class="me1">forward_port</span> <span class="nu0">22</span>, <span class="nu0">2222</span>, <span class="re3">:auto</span> <span class="sy0">=></span> <span class="kw2">true</span><br /> &nbsp; &nbsp; app_config.<span class="me1">vm</span>.<span class="me1">forward_port</span> <span class="nu0">80</span>, <span class="nu0">4567</span><br /> &nbsp; &nbsp; <span class="co1"># app_config.vm.network :hostonly, "33.33.13.37"</span><br /> &nbsp; &nbsp; <span class="co1"># config.vm.boot_mode = :gui</span><br /> <br /> &nbsp; &nbsp; app_config.<span class="me1">vm</span>.<span class="me1">provision</span> <span class="re3">:shell</span>, <span class="re3">:path</span> <span class="sy0">=></span> <span class="st0">"script-install-proxy.sh"</span><br /> &nbsp; <span class="kw1">end</span><br /> <br /> &nbsp; config.<span class="me1">vm</span>.<span class="me1">define</span> <span class="re3">:chef</span> <span class="kw1">do</span> <span class="sy0">|</span>app_config<span class="sy0">|</span><br /> &nbsp; &nbsp; app_config.<span class="me1">vm</span>.<span class="me1">customize</span> <span class="br0">&#91;</span><span class="st0">"modifyvm"</span>, <span class="re3">:id</span>, <span class="st0">"--name"</span>, <span class="st0">"script"</span>, <span class="st0">"--memory"</span>, <span class="st0">"256"</span><span class="br0">&#93;</span><br /> &nbsp; &nbsp; app_config.<span class="me1">vm</span>.<span class="me1">box</span> = <span class="st0">"chef"</span><br /> &nbsp; &nbsp; app_config.<span class="me1">vm</span>.<span class="me1">host_name</span> = <span class="st0">"chef"</span><br /> &nbsp; &nbsp; app_config.<span class="me1">vm</span>.<span class="me1">forward_port</span> <span class="nu0">22</span>, <span class="nu0">2222</span>, <span class="re3">:auto</span> <span class="sy0">=></span> <span class="kw2">true</span><br /> <br /> &nbsp; &nbsp; <span class="co1"># sudo apt-get install chef</span><br /> &nbsp; &nbsp; app_config.<span class="me1">vm</span>.<span class="me1">provision</span> <span class="re3">:chef_solo</span> <span class="kw1">do</span> <span class="sy0">|</span>chef<span class="sy0">|</span><br /> &nbsp; &nbsp; &nbsp; chef.<span class="me1">cookbooks_path</span> = <span class="st0">"cookbooks"</span><br /> &nbsp; &nbsp; &nbsp; chef.<span class="me1">add_recipe</span><span class="br0">&#40;</span><span class="st0">"nginx"</span><span class="br0">&#41;</span><br /> &nbsp; &nbsp; <span class="kw1">end</span><br /> &nbsp; <span class="kw1">end</span><br /> <br /> &nbsp; config.<span class="me1">vm</span>.<span class="me1">define</span> <span class="re3">:puppet</span> <span class="kw1">do</span> <span class="sy0">|</span>app_config<span class="sy0">|</span><br /> &nbsp; &nbsp; app_config.<span class="me1">vm</span>.<span class="me1">customize</span> <span class="br0">&#91;</span><span class="st0">"modifyvm"</span>, <span class="re3">:id</span>, <span class="st0">"--name"</span>, <span class="st0">"script"</span>, <span class="st0">"--memory"</span>, <span class="st0">"256"</span><span class="br0">&#93;</span><br /> &nbsp; &nbsp; app_config.<span class="me1">vm</span>.<span class="me1">box</span> = <span class="st0">"puppet"</span><br /> &nbsp; &nbsp; app_config.<span class="me1">vm</span>.<span class="me1">host_name</span> = <span class="st0">"puppet"</span><br /> &nbsp; &nbsp; app_config.<span class="me1">vm</span>.<span class="me1">forward_port</span> <span class="nu0">22</span>, <span class="nu0">2222</span>, <span class="re3">:auto</span> <span class="sy0">=></span> <span class="kw2">true</span><br /> <br /> &nbsp; &nbsp; <span class="co1"># sudo vi /etc/puppet/puppet.conf</span><br /> &nbsp; &nbsp; <span class="co1"># sudo apt-get install puppet-common</span><br /> &nbsp; &nbsp; app_config.<span class="me1">vm</span>.<span class="me1">provision</span> <span class="re3">:puppet</span> <span class="kw1">do</span> <span class="sy0">|</span>puppet<span class="sy0">|</span><br /> &nbsp; &nbsp; &nbsp; puppet.<span class="me1">manifests_path</span> = <span class="st0">"manifests"</span><br /> &nbsp; &nbsp; <span class="kw1">end</span><br /> &nbsp; <span class="kw1">end</span><br /> <span class="kw1">end</span>
  </div>
</div>

Avec tout ça, vous avez 3 VM avec du provisioning :

  * avec un script
  * chef
  * puppet

Du cache local (au niveau de votre machine hôte) pour APT et Gems, que vous pouvez adapter pour vos besoins.

La suite au prochain épisode&#8230;

 [1]: http://breizhcamp.org/ "Breizhcamp"