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
Next step of [{{ site.url }}informatique/tips/editer-un-fichier-directement-en-ftp-avec-vim/][1]

I would like to edit /etc/init.d/squid on bozzo host:

{% highlight bash %}
vim scp://bozzo//etc/init.d/squid
{% endhighlight %}

If you try with:

{% highlight bash %}
vim scp://bozzo/etc/init.d/squid
{% endhighlight %}

vim edit the file &laquo;&nbsp;etc/init.d/squid&nbsp;&raquo; in user home directory (/root/etc/squid/squid.conf in normal root account)

 [1]: {{ site.url }}informatique/tips/editer-un-fichier-directement-en-ftp-avec-vim/ "Edit a file with vim over FTP"
