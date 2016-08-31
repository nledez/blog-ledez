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

{% highlight bash %}
svcadm enable un_service
{% endhighlight %}

Pour avoir les informations sur le service

{% highlight bash %}
svcs -l le_service
{% endhighlight %}
