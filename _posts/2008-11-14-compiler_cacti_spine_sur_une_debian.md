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

<div class="codecolorer-container text default" style="overflow:auto;white-space:nowrap;">
  <div class="text codecolorer">
    checking for ranlib... ranlib<br /> checking for strip... strip<br /> checking for correct ltmain.sh version... no<br /> configure: error:
  </div>
</div>

\*\\*\* [Gentoo] sanity check failed! \*\**  
\*\\*\* libtool.m4 and ltmain.sh have a version mismatch! \*\**  
\*\\*\* (libtool.m4 = 1.5.22, ltmain.sh = &laquo;&nbsp;1.5.22 Debian 1.5.22-4&nbsp;&raquo;) \*\**

Please run:

libtoolize &#8211;copy &#8211;force

if appropriate, please contact the maintainer of this  
package (or your distribution) for help.

Donc pour gagner du temps dans mes recherches dans Google la prochaine fois, Nicolas fait ça :

<div class="codecolorer-container text default" style="overflow:auto;white-space:nowrap;">
  <div class="text codecolorer">
    aclocal && libtoolize --force && autoconf && autoheader && automake && ./configure && make
  </div>
</div>

Et voilà ! Un Spine tout frais !