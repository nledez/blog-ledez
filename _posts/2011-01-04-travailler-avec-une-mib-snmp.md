---
id: 94
title: Travailler avec une mib snmp
author: Nicolas Ledez
layout: post
guid: http://nicolas.ledez.free.fr/blog/?p=94
permalink: /informatique/travailler-avec-une-mib-snmp/
categories:
  - Informatique
  - Tips
tags:
  - cacti
  - linux
  - sed
  - shell
  - tips
  - unix
---
Par exemple pour travailler avec une mib netapp :

{% highlight bash %}
snmptranslate -m NETWORK-APPLIANCE-MIB -Tl|less
{% endhighlight %}


Pour avoir la liste de tous les paramètres avec leurs &laquo;&nbsp;valeurs&nbsp;&raquo; :

{% highlight text %}
.iso(1).org(3).dod(6).internet(1).mgmt(2).mib-2(1).interfaces(2).ifTable(2).ifEntry(1).ifOutErrors(20)
.iso(1).org(3).dod(6).internet(1).mgmt(2).mib-2(1).interfaces(2).ifTable(2).ifEntry(1).ifOutQLen(21)
.iso(1).org(3).dod(6).internet(1).mgmt(2).mib-2(1).interfaces(2).ifTable(2).ifEntry(1).ifSpecific(22)
{% endhighlight %}


Pour traduire ça avec une petite ligne :

{% highlight bash %}
echo '.iso(1).org(3).dod(6).internet(1).mgmt(2).mib-2(1).interfaces(2).ifTable(2).ifEntry(1).ifSpecific(22)' | perl -pe 's/\.[a-zA-Z-0-9]+\(/./g;s/\)//g'
.1.3.6.1.2.1.2.2.1.22
{% endhighlight %}


Et l&rsquo;inverse :

{% highlight bash %}
snmptranslate -m NETWORK-APPLIANCE-MIB -Tl .1.3.6.1.4.1.789.1.7.3.1.1.5.0
NETWORK-APPLIANCE-MIB::cifsReads.0
{% endhighlight %}
