---
id: 44
title: Editer un fichier directement en FTP avec VIM
author: Nicolas Ledez
layout: post
guid: http://nicolas.ledez.free.fr/blog/?p=44/2006/12/11/editer-un-fichier-directement-en-ftp-avec-vim/
permalink: /informatique/tips/editer-un-fichier-directement-en-ftp-avec-vim/
categories:
  - Tips
---
<div class="codecolorer-container text default" style="overflow:auto;white-space:nowrap;">
  <div class="text codecolorer">
    vim ftp://mon_utilisateur@mon_serveur_ftp/un_repertoire/un_fichier.ext
  </div>
</div>

ou

<div class="codecolorer-container text default" style="overflow:auto;white-space:nowrap;">
  <div class="text codecolorer">
    vim ftp://mon_utilisateur@mon_serveur_ftp/un_fichier.ext
  </div>
</div>

Et pas :

<div class="codecolorer-container text default" style="overflow:auto;white-space:nowrap;">
  <div class="text codecolorer">
    vim ftp://mon_utilisateur@mon_serveur_ftp:un_repertoire/un_fichier.ext
  </div>
</div>

L&rsquo;éditeur va demander le mot de passe FTP et c&rsquo;est partit. Donc plus besoin de modifier le fichier en local pour le renvoyer en FTP&#8230;