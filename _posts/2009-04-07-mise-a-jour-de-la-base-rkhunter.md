---
id: 113
title: Mise à jour de la base rkhunter
author: Nicolas Ledez
layout: post
guid: http://blog.ledez.net/?p=113
permalink: /divers/mise-a-jour-de-la-base-rkhunter/
categories:
  - Divers
tags:
  - Sécurité
---
<div class="codecolorer-container text default" style="overflow:auto;white-space:nowrap;">
  <div class="text codecolorer">
    Warning: The file properties have changed:<br /> File: /usr/bin/curl<br /> Current inode: 1738    Stored inode: 285619<br /> Current file modification time: 1236689477<br /> Stored file modification time : 1230384786
  </div>
</div>

Et un &laquo;&nbsp;rkhunter &#8211;update&nbsp;&raquo; ne met à jour que les bases listant les rootkit. Pour mettre à jour la base locale, il faut faire :

<div class="codecolorer-container text default" style="overflow:auto;white-space:nowrap;">
  <div class="text codecolorer">
    rkhunter --propupd
  </div>
</div>