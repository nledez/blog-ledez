---
id: 47
title: 'service imap pid 32188 in BUSY state: terminated abnormally'
author: Nicolas Ledez
layout: post
guid: http://nicolas.ledez.free.fr/blog/index.php/47/2007/01/29/service-imap-pid-32188-in-busy-state-terminated-abnormally/
permalink: /informatique/service-imap-pid-32188-in-busy-state-terminated-abnormally/
categories:
  - Informatique
  - OpenSource
---
We have this error on my IMAP server :

{% highlight text %}
    cyrus/master[32170]: service imap pid 32188 in BUSY state: terminated abnormally
{% endhighlight %}

We have a Debian sid with cyrus21 & openldap authentification.

I solve this with a :

{% highlight bash %}
    chmod 644 /etc/libnss-ldap.conf
{% endhighlight %}
