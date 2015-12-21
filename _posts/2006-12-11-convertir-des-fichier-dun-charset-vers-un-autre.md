---
id: 46
title: 'Convertir des fichier d&rsquo;un charset vers un autre'
author: Nicolas Ledez
layout: post
guid: http://nicolas.ledez.free.fr/blog/index.php/46/2006/12/11/convertir-des-fichier-dun-charset-vers-un-autre/
permalink: /informatique/tips/convertir-des-fichier-dun-charset-vers-un-autre/
categories:
  - Tips
---
J&rsquo;ai enfin une solution simple pour convertir un fichier d&rsquo;un charset vers un autre :

<div class="codecolorer-container text default" style="overflow:auto;white-space:nowrap;">
  <div class="text codecolorer">
    iconv --from-code=ISO-8859-1 --to-code=UTF-8 le_fichier_iso > le_fichier_utf8
  </div>
</div>

A l&rsquo;inverse :

<div class="codecolorer-container text default" style="overflow:auto;white-space:nowrap;">
  <div class="text codecolorer">
    iconv --from-code=UTF-8 --to-code=ISO-8859-1 le_fichier_utf8 > le_fichier_iso
  </div>
</div>

<http://www.kriyayoga.com/love_blog/post.php/224>