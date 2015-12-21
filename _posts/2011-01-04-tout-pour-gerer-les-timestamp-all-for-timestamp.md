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

<div class="codecolorer-container bash default" style="overflow:auto;white-space:nowrap;">
  <div class="bash codecolorer">
    <span class="kw2">perl</span> <span class="re5">-e</span> <span class="st_h">'print time;'</span><br /> <span class="kw2">date</span> +<span class="sy0">%</span>s
  </div>
</div>

Le timespamp de la veille / Yesterday timestamp:

<div class="codecolorer-container bash default" style="overflow:auto;white-space:nowrap;">
  <div class="bash codecolorer">
    <span class="kw2">perl</span> <span class="re5">-e</span> <span class="st_h">'print time-1*86400;'</span><br /> <span class="kw2">date</span> <span class="re5">-d</span> <span class="st_h">'1 day ago'</span> +<span class="sy0">%</span>s <span class="co0"># Work only with up-to-date date such as Linux</span>
  </div>
</div>