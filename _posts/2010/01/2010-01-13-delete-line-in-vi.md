---
id: 134
title: Delete line in vi
author: Nicolas Ledez
layout: post
guid: http://blog.ledez.net/?p=134
permalink: /divers/delete-line-in-vi/
categories:
  - Divers
  - Tips
tags:
  - tips
  - vim
---
To delete line in vi(m) if line respect a pattern :

{% highlight viml %}
:g/^#/ d
{% endhighlight %}

Is delete comment lines

{% highlight viml %}
:g/^$/ d
{% endhighlight %}

Is delete empty lines
