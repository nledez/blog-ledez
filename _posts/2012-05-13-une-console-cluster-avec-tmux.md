---
id: 481
title: Une console cluster avec tmux
author: Nicolas Ledez
layout: post
guid: http://blog.ledez.net/?p=481
permalink: /informatique/une-console-cluster-avec-tmux/
categories:
  - Informatique
tags:
  - cluster
  - tmux
  - unix
---
Tous ceux qui ont déjà travaillé avec un cluster le savent bien. Il faut avec deux machines &laquo;&nbsp;strictement&nbsp;&raquo; identiques.

La meilleure solution est d&rsquo;avoir une &laquo;&nbsp;console cluster&nbsp;&raquo;. Je n&rsquo;ai jamais trouvé de solution réellement efficace et pratique à utiliser (la plus pratique celle de SUN).

Bref. En parallèle, je voulais regarder ce que [Tmux][1] avait dans le ventre pour remplacer [Screen][2] qui a fait son temps.

Et en pleine lecture de [tmux: Productive Mouse-Free Development][3], je me rends compte qu&rsquo;il est surement possible d&rsquo;en faire une super console pour cluster.

Fichier &laquo;&nbsp;.tmux-clust.conf&nbsp;&raquo;

<div class="codecolorer-container bash default" style="overflow:auto;white-space:nowrap;">
  <div class="bash codecolorer">
    new-session <span class="re5">-d</span> <span class="re5">-s</span> clust <span class="re5">-n</span> clust1 <span class="st_h">'ssh clust-root1'</span><br /> split-window <span class="re5">-v</span> <span class="re5">-t</span> clust <span class="st_h">'ssh clust-root2'</span><br /> <span class="kw1">set</span> <span class="re5">-g</span> status-right <span class="st0">""</span><br /> source-file ~<span class="sy0">/</span>.tmux-clust-bc.conf
  </div>
</div>

Fichier &laquo;&nbsp;.tmux-clust-bc.conf&nbsp;&raquo;

<div class="codecolorer-container bash default" style="overflow:auto;white-space:nowrap;">
  <div class="bash codecolorer">
    set-window-option synchronize-panes on<br /> <span class="kw3">bind</span> r source-file ~<span class="sy0">/</span>.tmux-clust-nobc.conf \; display <span class="st0">"Stop broadcast"</span><br /> <span class="kw1">set</span> <span class="re5">-g</span> status-bg green<br /> <span class="kw1">set</span> <span class="re5">-g</span> pane-active-border-fg green<br /> unbind u<br /> unbind i<br /> unbind o<br /> unbind p<br /> <br /> <span class="kw3">bind</span> u set-window-option synchronize-panes off \; send-keys <span class="re5">-t</span> clust:<span class="nu0">0.0</span> <span class="st_h">'1'</span> \; send-keys <span class="re5">-t</span> clust:<span class="nu0">0.1</span> <span class="st_h">'2'</span> \; set-window-option synchronize-panes on<br /> <span class="kw3">bind</span> i set-window-option synchronize-panes off \; send-keys <span class="re5">-t</span> clust:<span class="nu0">0.0</span> <span class="st_h">'2'</span> \; send-keys <span class="re5">-t</span> clust:<span class="nu0">0.1</span> <span class="st_h">'1'</span> \; set-window-option synchronize-panes on<br /> <span class="kw3">bind</span> o set-window-option synchronize-panes off \; send-keys <span class="re5">-t</span> clust:<span class="nu0">0.0</span> <span class="st_h">'192.168.21.'</span> \; send-keys <span class="re5">-t</span> clust:<span class="nu0">0.1</span> <span class="st_h">'192.168.22.'</span> \; set-window-option synchronize-panes on<br /> <span class="kw3">bind</span> p set-window-option synchronize-panes off \; send-keys <span class="re5">-t</span> clust:<span class="nu0">0.0</span> <span class="st_h">'192.168.22.'</span> \; send-keys <span class="re5">-t</span> clust:<span class="nu0">0.1</span> <span class="st_h">'192.168.21.'</span> \; set-window-option synchronize-panes on
  </div>
</div>

Fichier &laquo;&nbsp;.tmux-clust-nobc.conf&nbsp;&raquo;

<div class="codecolorer-container bash default" style="overflow:auto;white-space:nowrap;">
  <div class="bash codecolorer">
    set-window-option synchronize-panes off<br /> <span class="kw3">bind</span> r source-file ~<span class="sy0">/</span>.tmux-clust-bc.conf \; display <span class="st0">"Now with broadcast"</span><br /> <span class="kw1">set</span> <span class="re5">-g</span> status-bg blue<br /> <span class="kw1">set</span> <span class="re5">-g</span> pane-active-border-fg blue<br /> <br /> unbind u<br /> unbind i<br /> unbind o<br /> unbind p<br /> <span class="kw3">bind</span> u send-keys <span class="re5">-t</span> clust:<span class="nu0">0.0</span> <span class="st_h">'1'</span> \; send-keys <span class="re5">-t</span> clust:<span class="nu0">0.1</span> <span class="st_h">'2'</span><br /> <span class="kw3">bind</span> i send-keys <span class="re5">-t</span> clust:<span class="nu0">0.0</span> <span class="st_h">'2'</span> \; send-keys <span class="re5">-t</span> clust:<span class="nu0">0.1</span> <span class="st_h">'1'</span><br /> <span class="kw3">bind</span> o send-keys <span class="re5">-t</span> clust:<span class="nu0">0.0</span> <span class="st_h">'192.168.21.'</span> \; send-keys <span class="re5">-t</span> clust:<span class="nu0">0.1</span> <span class="st_h">'192.168.22.'</span><br /> <span class="kw3">bind</span> p send-keys <span class="re5">-t</span> clust:<span class="nu0">0.0</span> <span class="st_h">'192.168.22.'</span> \; send-keys <span class="re5">-t</span> clust:<span class="nu0">0.1</span> <span class="st_h">'192.168.21.'</span>
  </div>
</div>

Et pour finir le fichier &laquo;&nbsp;tmux-clust&nbsp;&raquo;

<div class="codecolorer-container bash default" style="overflow:auto;white-space:nowrap;">
  <div class="bash codecolorer">
    <span class="co0">#!/bin/bash</span><br /> tmux <span class="re5">-f</span> ~<span class="sy0">/</span>.tmux-clust.conf attach
  </div>
</div>

Du coup, quand je me connecte avec le script &laquo;&nbsp;tmux-clust&nbsp;&raquo;, il lance une connexion vers clust-root1 et clust-root2 chacun dans un panneau. Et par défaut, on est dans le mode &laquo;&nbsp;bc&nbsp;&raquo; pour broadcast.

Les touches :

  * C-b u -> 1 -> node
  * C-b i -> 2 -> other_node
  * C-b o -> 192.168.21 -> node\_addr\_base
  * C-b p -> 192.168.22 -> other\_addr\_base
  * C-b r -> Change broadcast mode

&laquo;&nbsp;C-b r&nbsp;&raquo; permet de passer d&rsquo;un &laquo;&nbsp;mode&nbsp;&raquo; à un autre :  
&#8211; Vert &laquo;&nbsp;broadcast&nbsp;&raquo; on envoie la purée sur les deux machines en même temps  
&#8211; Bleu mode normal C-b fléche pour passer de l&rsquo;un à l&rsquo;autre

Et voila, une console cluster en mieux :p

 [1]: http://tmux.sourceforge.net/ "Tmux - le site"
 [2]: https://www.gnu.org/software/screen/ "Screen - Le 'site'"
 [3]: http://pragprog.com/book/bhtmux/tmux "tmux: Productive Mouse-Free Development"