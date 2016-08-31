---
id: 125
title: 'Tout pour gérer les timestamp &#8211; All for timestamp'
author: Nicolas Ledez
layout: post
guid: http://blog.ledez.net/?p=125
permalink: /informatique/tout-pour-gerer-les-timestamp-all-for-timestamp/
categories:
  - Informatique
  - Tips
tags:
  - howto
  - perl
  - shell
  - tips
  - unix
---
Afficher le timestamp courant / print current timestamp:

{% highlight bash %}
perl -e 'print time;'
date +%s
{% endhighlight %}

Le timespamp de la veille / Yesterday timestamp:

{% highlight bash %}
perl -e 'print time-1*86400;'
date -d '1 day ago' +%s # Work only with up-to-date date such as Linux
{% endhighlight %}
