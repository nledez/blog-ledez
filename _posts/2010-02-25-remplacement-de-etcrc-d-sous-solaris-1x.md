---
id: 144
title: 'Remplacement de /etc/rc?.d/* sous Solaris 1x'
author: Nicolas Ledez
layout: post
guid: http://blog.ledez.net/?p=144
permalink: /informatique/tips/remplacement-de-etcrc-d-sous-solaris-1x/
categories:
  - Tips
---
Pour activer un service au démarage de la machine :

<div class="codecolorer-container text default" style="overflow:auto;white-space:nowrap;">
  <div class="text codecolorer">
    svcadm enable un_service
  </div>
</div>

Pour avoir les informations sur le service

<div class="codecolorer-container text default" style="overflow:auto;white-space:nowrap;">
  <div class="text codecolorer">
    svcs -l le_service
  </div>
</div>