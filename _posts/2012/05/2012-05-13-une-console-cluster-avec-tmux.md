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

{% highlight bash %}
new-session -d -s clust -n clust1 'ssh clust-root1'
split-window -v -t clust 'ssh clust-root2'
set -g status-right ""
source-file ~/.tmux-clust-bc.conf
{% endhighlight %}

Fichier &laquo;&nbsp;.tmux-clust-bc.conf&nbsp;&raquo;

{% highlight bash %}
set-window-option synchronize-panes on
bind r source-file ~/.tmux-clust-nobc.conf \; display "Stop broadcast"
set -g status-bg green
set -g pane-active-border-fg green
unbind u
unbind i
unbind o
unbind p

bind u set-window-option synchronize-panes off \; send-keys -t clust:0.0 '1' \; send-keys -t clust:0.1 '2' \; set-window-option synchronize-panes on
bind i set-window-option synchronize-panes off \; send-keys -t clust:0.0 '2' \; send-keys -t clust:0.1 '1' \; set-window-option synchronize-panes on
bind o set-window-option synchronize-panes off \; send-keys -t clust:0.0 '192.168.21.' \; send-keys -t clust:0.1 '192.168.22.' \; set-window-option synchronize-panes on
bind p set-window-option synchronize-panes off \; send-keys -t clust:0.0 '192.168.22.' \; send-keys -t clust:0.1 '192.168.21.' \; set-window-option synchronize-panes on
{% endhighlight %}

Fichier &laquo;&nbsp;.tmux-clust-nobc.conf&nbsp;&raquo;

{% highlight bash %}
set-window-option synchronize-panes off
bind r source-file ~/.tmux-clust-bc.conf \; display "Now with broadcast"
set -g status-bg blue
set -g pane-active-border-fg blue

unbind u
unbind i
unbind o
unbind p
bind u send-keys -t clust:0.0 '1' \; send-keys -t clust:0.1 '2'
bind i send-keys -t clust:0.0 '2' \; send-keys -t clust:0.1 '1'
bind o send-keys -t clust:0.0 '192.168.21.' \; send-keys -t clust:0.1 '192.168.22.'
bind p send-keys -t clust:0.0 '192.168.22.' \; send-keys -t clust:0.1 '192.168.21.'
{% endhighlight %}

Et pour finir le fichier &laquo;&nbsp;tmux-clust&nbsp;&raquo;

{% highlight bash %}
#!/bin/bash
tmux -f ~/.tmux-clust.conf attach
{% endhighlight %}

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
