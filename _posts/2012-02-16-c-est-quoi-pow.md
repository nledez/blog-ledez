---
id: 374
title: 'C&rsquo;est quoi Pow ?'
author: Nicolas Ledez
layout: post
guid: http://blog.ledez.net/?p=374
permalink: /informatique/ruby/c-est-quoi-pow/
categories:
  - Ruby
tags:
  - mac
  - osx
  - pow
  - rails
  - ruby
---
Pour répondre à un commentaire, sur mon prétendent [Post &laquo;&nbsp;Pow pour les nuls&nbsp;&raquo;][1] :

Pour un développeur web 2 étapes dans la vie du projet :

  * Développement
  * Production

<!--more-->

  
<span class="Apple-style-span" style="line-height: 18px;">Pour un développeur Rails (en général, mais vous pouvez utiliser autre chose) :</span>

  * Développement => le serveur &laquo;&nbsp;Rails&nbsp;&raquo; embarqué
  * Production => Ex : Ngnix + Passenger

<div>
  <span class="Apple-style-span" style="line-height: 18px;">Le serveur de développement est WEBrick, il est génial dans le sens ou il tourne simplement sur toutes les plates-formes sans configuration. Ex :</span>
</div>

<div class="codecolorer-container bash default" style="overflow:auto;white-space:nowrap;">
  <div class="bash codecolorer">
    <span class="sy0">%</span> rails s &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<span class="sy0">!</span><span class="nu0">6566</span><br /> =<span class="sy0">></span> Booting WEBrick<br /> =<span class="sy0">></span> Rails 3.2.0 application starting <span class="kw1">in</span> development on http:<span class="sy0">//</span>0.0.0.0:<span class="nu0">3000</span><br /> =<span class="sy0">></span> Call with <span class="re5">-d</span> to detach<br /> =<span class="sy0">></span> Ctrl-C to shutdown server<br /> <span class="br0">&#91;</span><span class="nu0">2012</span>-02-<span class="nu0">16</span> <span class="nu0">13</span>:03:<span class="nu0">21</span><span class="br0">&#93;</span> INFO &nbsp;WEBrick 1.3.1<br /> <span class="br0">&#91;</span><span class="nu0">2012</span>-02-<span class="nu0">16</span> <span class="nu0">13</span>:03:<span class="nu0">21</span><span class="br0">&#93;</span> INFO &nbsp;ruby 1.9.3 <span class="br0">&#40;</span><span class="nu0">2011</span>-<span class="nu0">10</span>-<span class="nu0">30</span><span class="br0">&#41;</span> <span class="br0">&#91;</span>x86_64-darwin11.2.0<span class="br0">&#93;</span><br /> <span class="br0">&#91;</span><span class="nu0">2012</span>-02-<span class="nu0">16</span> <span class="nu0">13</span>:03:<span class="nu0">21</span><span class="br0">&#93;</span> INFO &nbsp;WEBrick::HTTPServer<span class="co0">#start: pid=69469 port=3000</span>
  </div>
</div>

<div>
  <span class="Apple-style-span" style="line-height: 18px;">Un navigateur web sur http://localhost:3000/ et c&rsquo;est parti. Ca marche aussi sur http://127.0.0.1:3000/ :).</span>
</div>

<div>
</div>

<div>
  <p>
    Les inconvénients que j&rsquo;arrive à trouver :
  </p>
  
  <ul>
    <li>
      Il faut aller en ligne de commande pour ouvrir le serveur
    </li>
    <li>
      On ne peut simplement lancer qu&rsquo;un seul serveur à la fois (sinon, &laquo;&nbsp;-p <un autre port>&nbsp;&raquo;, pour binder sur un autre port)
    </li>
    <li>
      L&rsquo;historique va mélanger toutes les applications dans les URL
    </li>
  </ul>
  
  <div>
    <span class="Apple-style-span" style="line-height: 18px;">Maintenant que je suis convaincu de passer à autre chose <img src="https://blog.ledez.net/wp-includes/images/smilies/simple-smile.png" alt=":)" class="wp-smiley" style="height: 1em; max-height: 1em;" /> :</span>
  </div>
</div>

<div>
</div>

<div>
  Et bien les mecs de <a title="site de 37signals" href="http://37signals.com/">37signals</a> ont fait un super outil pour Mac : <a title="Le site de Pow" href="http://pow.cx/">Pow</a>
</div>

<div>
</div>

<div>
  Pow permet d&rsquo;avoir un &laquo;&nbsp;serveur Rails&nbsp;&raquo; hyper simple à installer et zéro configuration.
</div>

<div>
</div>

<div>
  Avantages :
</div>

<div>
  <ul>
    <li>
      <span class="Apple-style-span" style="line-height: 19px;">Pas de ligne de commande</span>
    </li>
    <li>
      <span class="Apple-style-span" style="line-height: 19px;">Toutes mes applications peuvent tourner en même temps</span>
    </li>
    <li>
      <span class="Apple-style-span" style="line-height: 19px;">On est &laquo;&nbsp;proche&nbsp;&raquo; d&rsquo;une configuration de production</span>
    </li>
  </ul>
  
  <div>
    Voilà, je pense vous avoir donné envie d&rsquo;acheter un Mac et de lire mon autre article &laquo;&nbsp;<a title="Pow pour les nuls" href="http://blog.ledez.net/informatique/tips/pow-pour-les-nuls/">Pow pour les nuls</a>&laquo;&nbsp;
  </div>
</div>

 [1]: http://blog.ledez.net/informatique/tips/pow-pour-les-nuls/ "Pow pour les nuls"