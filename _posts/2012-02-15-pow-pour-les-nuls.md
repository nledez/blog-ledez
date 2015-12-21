---
id: 356
title: Pow pour les nuls
author: Nicolas Ledez
layout: post
guid: http://blog.ledez.net/?p=356
permalink: /informatique/tips/pow-pour-les-nuls/
categories:
  - Ruby
  - Tips
tags:
  - mac
  - osx
  - pow
  - rails
  - ruby
  - zsh
---
Toutes les étapes pour avoir une machine avec un Pow et Zsh qui torchent ! :

  * Installer Pow
  * Installer OH MY ZSHELL!
  * Modification de la configuration par défaut
  * Et son utilisation
  * Bonus

<!--more-->

### Installer Pow

[Extrait du site de Pow][1]  
C&rsquo;est le plus dur :p

<div class="codecolorer-container bash default" style="overflow:auto;white-space:nowrap;">
  <div class="bash codecolorer">
    <span class="co4">$ </span>curl get.pow.cx <span class="sy0">|</span> <span class="kw2">sh</span>
  </div>
</div>

Maintenant une connexion sur un site http://<app>.dev/ doit fonctionner.  
Pour une nouvelle application, le mode opératoire est simple :

<div class="codecolorer-container bash default" style="overflow:auto;white-space:nowrap;">
  <div class="bash codecolorer">
    $ <span class="kw3">cd</span> ~<span class="sy0">/</span>.pow<br /> $ <span class="kw2">ln</span> <span class="re5">-s</span> <span class="sy0">/</span>path<span class="sy0">/</span>to<span class="sy0">/</span>myapp
  </div>
</div>

Pff trop la flemme&#8230;

Pour gagner du temps, on va installer ZSH, avec le plugin &laquo;&nbsp;quivabien&nbsp;&raquo; :

### Installer OH MY ZSHELL!

[Extrait du site oh-my-zsh][2]

<div class="codecolorer-container bash default" style="overflow:auto;white-space:nowrap;">
  <div class="bash codecolorer">
    <span class="co4">$ </span>curl <span class="re5">-L</span> https:<span class="sy0">//</span>github.com<span class="sy0">/</span>robbyrussell<span class="sy0">/</span>oh-my-zsh<span class="sy0">/</span>raw<span class="sy0">/</span>master<span class="sy0">/</span>tools<span class="sy0">/</span>install.sh <span class="sy0">|</span> <span class="kw2">sh</span>
  </div>
</div>

Si jamais votre Shell par défaut est écrasé (en général bash). Vous pouvez revenir en arrière :

<div class="codecolorer-container bash default" style="overflow:auto;white-space:nowrap;">
  <div class="bash codecolorer">
    <span class="kw2">chsh</span> <span class="re5">-s</span> <span class="sy0">/</span>bin<span class="sy0">/</span><span class="kw2">bash</span>
  </div>
</div>

### Modification de la configuration par défaut

Modifier la ligne dans le fichier ~/.zshrc :

<div class="codecolorer-container bash default" style="overflow:auto;white-space:nowrap;">
  <div class="bash codecolorer">
    <span class="re2">plugins</span>=<span class="br0">&#40;</span><span class="kw2">git</span> brew bundler gem heroku osx pow rails3 redis-cli textmate<span class="br0">&#41;</span>
  </div>
</div>

C&rsquo;est surtout le plugin pow qu&rsquo;il faut mettre, les autres sont ceux que j&rsquo;utilise. Choisissez vos armes.

### Et son utilisation

Si l&rsquo;on regarde le contenu du fichier ~/.oh-my-zsh/plugins/pow/pow.plugin.zsh, on apprend qu&rsquo;il y a 3 commandes à disposition :

  * powit qui permet de &laquo;&nbsp;d&rsquo;installer&nbsp;&raquo; un nouveau site
  * kapow qui permet de redémarrer une application. Avec en argument le nom du vhost ou sans argument dans le répertoire de l&rsquo;application
  * kaput (puts) qui permet d&rsquo;afficher les logs de l&rsquo;application

### Bonus

Je ne me souviens jamais des URL à taper. Et j&rsquo;ai trop la (flemme|pas envie de faire peur à mon client), j&rsquo;aimerais donc avoir l&rsquo;adresse http://index.dev/ qui me donne la liste de toutes mes applications.

On peut utiliser dans ce cas l&rsquo;application [Pow-index][3].

Si vous n&rsquo;avez pas ça :

<div class="codecolorer-container bash default" style="overflow:auto;white-space:nowrap;">
  <div class="bash codecolorer">
    <span class="sy0">%</span> gem search <span class="re5">--remote</span> pow-index &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<span class="sy0">!</span><span class="nu0">6441</span><br /> <br /> <span class="sy0">***</span> REMOTE GEMS <span class="sy0">***</span><br /> <br /> pow-index <span class="br0">&#40;</span>0.0.4<span class="br0">&#41;</span>
  </div>
</div>

Regardez plus bas (la version git).

Sans [RVM][4] :

<div class="codecolorer-container bash default" style="overflow:auto;white-space:nowrap;">
  <div class="bash codecolorer">
    $ gem <span class="kw2">install</span> pow-index<br /> $ pow-index index
  </div>
</div>

Avec [RVM][4] :

<div class="codecolorer-container bash default" style="overflow:auto;white-space:nowrap;">
  <div class="bash codecolorer">
    $ rvm use default<span class="sy0">@</span>pow-index <span class="re5">--create</span><br /> $ gem <span class="kw2">install</span> pow-index<br /> $ pow-index index<br /> $ gem <span class="kw2">which</span> pow-index<br /> $ <span class="kw3">cd</span> $<span class="br0">&#40;</span>gem <span class="kw2">which</span> pow-index <span class="sy0">|</span> <span class="kw2">sed</span> <span class="st_h">'s#lib/pow-index.rb$##'</span><span class="br0">&#41;</span><br /> $ <span class="kw3">echo</span> <span class="st_h">'rvm use default@pow-index'</span> <span class="sy0">&</span>gt; .rvmrc
  </div>
</div>

J&rsquo;ai fais quelques modifications suplémentaires dans un fork sur Github, [@marutanm][5] répond rapidement aux pull-request il devrait donc y avoir une version 0.0.5. En attendant :

<div class="codecolorer-container bash default" style="overflow:auto;white-space:nowrap;">
  <div class="bash codecolorer">
    $ <span class="kw2">git clone</span> https:<span class="sy0">//</span>nledez<span class="sy0">@</span>github.com<span class="sy0">/</span>nledez<span class="sy0">/</span>Pow-index.git<br /> $ <span class="kw3">cd</span> Pow-index<br /> $ <span class="kw2">ln</span> <span class="re5">-s</span> $<span class="br0">&#40;</span><span class="kw3">pwd</span><span class="br0">&#41;</span> ~<span class="sy0">/</span>.pow<span class="sy0">/</span>index
  </div>
</div>

Vous pouvez aussi remplacer index par default. Dans ce cas, n&rsquo;importe quelle URL qui se termine en .dev seras redirigé vers celui-là.

Et voilà plus qu&rsquo;à apprendre coder comme des malades <img src="https://blog.ledez.net/wp-includes/images/smilies/simple-smile.png" alt=":)" class="wp-smiley" style="height: 1em; max-height: 1em;" />

 [1]: http://pow.cx/ "Site de Pow"
 [2]: https://github.com/robbyrussell/oh-my-zsh "Site de oh-my-zsh"
 [3]: https://github.com/marutanm/Pow-index "Site de Pow-index"
 [4]: https://rvm.beginrescueend.com/ "Site de RVM"
 [5]: https://twitter.com/#!/marutanm "@marutanm"