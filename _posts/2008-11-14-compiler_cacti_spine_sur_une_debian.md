---
id: 105
title: Compiler Cacti Spine sur une Debian
author: Nicolas Ledez
layout: post
guid: http://nicolas.ledez.free.fr/blog/?p=98
permalink: /informatique/compiler_cacti_spine_sur_une_debian/
categories:
  - Informatique
  - OpenSource
---
A chaque fois que je veux compiler spine sous Debian, j&rsquo;ai cette erreur là :

{% highlight text %}
checking for ranlib... ranlib
checking for strip... strip
checking for correct ltmain.sh version... no
configure: error:
*** [Gentoo] sanity check failed! ***
*** libtool.m4 and ltmain.sh have a version mismatch! ***
*** (libtool.m4 = 1.5.22, ltmain.sh = « 1.5.22 Debian 1.5.22-4 ») ***

Please run:

libtoolize –copy –force

if appropriate, please contact the maintainer of this
package (or your distribution) for help.
{% endhighlight %}

Donc pour gagner du temps dans mes recherches dans Google la prochaine fois, Nicolas fait ça :

{% highlight bash %}
aclocal && libtoolize --force && autoconf && autoheader && automake && ./configure && make
{% endhighlight %}

Et voilà ! Un Spine tout frais !
