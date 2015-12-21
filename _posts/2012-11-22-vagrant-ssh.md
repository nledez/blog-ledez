---
id: 508
title: 'Vagrant &#038; SSH'
author: Nicolas Ledez
layout: post
guid: http://blog.ledez.net/?p=508
permalink: /informatique/vagrant-ssh/
categories:
  - Informatique
  - Tips
tags:
  - ssh
  - vagrant
---
Suite au Tweet : <a title="de @ndeloof" href="https://twitter.com/ndeloof/statuses/271386955785318400" target="_blank">https://twitter.com/ndeloof/statuses/271386955785318400</a>

Et que ma solution ne tient pas en 140 caractères :

<div class="codecolorer-container text default" style="overflow:auto;white-space:nowrap;">
  <div class="text codecolorer">
    ssh -p 2222 -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -i ~/.vagrant.d/insecure_private_key vagrant@localhost
  </div>
</div>

Sinon dans votre ~/.ssh/config :

<div class="codecolorer-container text default" style="overflow:auto;white-space:nowrap;">
  <div class="text codecolorer">
    Host vagrant-box<br /> &nbsp; Hostname localhost<br /> &nbsp; User vagrant<br /> &nbsp; Port 2222<br /> &nbsp; StrictHostKeyChecking no<br /> &nbsp; UserKnownHostsFile /dev/null<br /> &nbsp; IdentityFile ~/.vagrant.d/insecure_private_key
  </div>
</div>

Maintenant, vos :

<div class="codecolorer-container text default" style="overflow:auto;white-space:nowrap;">
  <div class="text codecolorer">
    ssh vagrant-box<br /> knife cook
  </div>
</div>

Vont marcher direct !