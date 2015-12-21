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
{% highlight text %}
Warning: The file properties have changed:
File: /usr/bin/curl
Current inode: 1738    Stored inode: 285619
Current file modification time: 1236689477
Stored file modification time : 1230384786
{% endhighlight %}

Et un &laquo;&nbsp;rkhunter &#8211;update&nbsp;&raquo; ne met à jour que les bases listant les rootkit. Pour mettre à jour la base locale, il faut faire :

{% highlight bash %}
rkhunter --propupd
{% endhighlight %}
