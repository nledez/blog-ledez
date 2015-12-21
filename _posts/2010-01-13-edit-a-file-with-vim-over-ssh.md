---
id: 128
title: Edit a file with vim over ssh
author: Nicolas Ledez
layout: post
guid: http://blog.ledez.net/?p=128
permalink: /informatique/edit-a-file-with-vim-over-ssh/
categories:
  - Informatique
  - Tips
tags:
  - ssh
  - tips
  - vim
---
Next step of [http://blog.ledez.net/informatique/tips/editer-un-fichier-directement-en-ftp-avec-vim/][1]

I would like to edit /etc/init.d/squid on bozzo host:

<div class="codecolorer-container text default" style="overflow:auto;white-space:nowrap;">
  <div class="text codecolorer">
    vim scp://bozzo//etc/init.d/squid
  </div>
</div>

If you try with:

<div class="codecolorer-container text default" style="overflow:auto;white-space:nowrap;">
  <div class="text codecolorer">
    vim scp://bozzo/etc/init.d/squid
  </div>
</div>

vim edit the file &laquo;&nbsp;etc/init.d/squid&nbsp;&raquo; in user home directory (/root/etc/squid/squid.conf in normal root account)

 [1]: http://blog.ledez.net/informatique/tips/editer-un-fichier-directement-en-ftp-avec-vim/ "Edit a file with vim over FTP"