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

<div class="codecolorer-container bash default" style="overflow:auto;white-space:nowrap;">
  <div class="bash codecolorer">
    snmptranslate <span class="re5">-m</span> NETWORK-APPLIANCE-MIB <span class="re5">-Tl</span><span class="sy0">|</span><span class="kw2">less</span>
  </div>
</div>

Pour avoir la liste de tous les paramètres avec leurs &laquo;&nbsp;valeurs&nbsp;&raquo; :

<div class="codecolorer-container text default" style="overflow:auto;white-space:nowrap;">
  <div class="text codecolorer">
    .iso(1).org(3).dod(6).internet(1).mgmt(2).mib-2(1).interfaces(2).ifTable(2).ifEntry(1).ifOutErrors(20)<br /> .iso(1).org(3).dod(6).internet(1).mgmt(2).mib-2(1).interfaces(2).ifTable(2).ifEntry(1).ifOutQLen(21)<br /> .iso(1).org(3).dod(6).internet(1).mgmt(2).mib-2(1).interfaces(2).ifTable(2).ifEntry(1).ifSpecific(22)
  </div>
</div>

Pour traduire ça avec une petite ligne :

<div class="codecolorer-container bash default" style="overflow:auto;white-space:nowrap;">
  <div class="bash codecolorer">
    <span class="kw3">echo</span> <span class="st_h">'.iso(1).org(3).dod(6).internet(1).mgmt(2).mib-2(1).interfaces(2).ifTable(2).ifEntry(1).ifSpecific(22)'</span> <span class="sy0">|</span> <span class="kw2">perl</span> <span class="re5">-pe</span> <span class="st_h">'s/\.[a-zA-Z-0-9]+\(/./g;s/\)//g'</span><br /> .1.3.6.1.2.1.2.2.1.22
  </div>
</div>

Et l&rsquo;inverse :

<div class="codecolorer-container bash default" style="overflow:auto;white-space:nowrap;">
  <div class="bash codecolorer">
    snmptranslate <span class="re5">-m</span> NETWORK-APPLIANCE-MIB <span class="re5">-Tl</span> .1.3.6.1.4.1.789.1.7.3.1.1.5.0<br /> NETWORK-APPLIANCE-MIB::cifsReads.0
  </div>
</div>