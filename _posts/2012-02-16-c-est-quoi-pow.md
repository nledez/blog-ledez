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
excerpt_separator: <!--more-->
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

{% highlight bash %}
% rails s
=> Booting WEBrick
=> Rails 3.2.0 application starting in development on http://0.0.0.0:3000
=> Call with -d to detach
=> Ctrl-C to shutdown server
[2012-02-16 13:03:21] INFO  WEBrick 1.3.1
[2012-02-16 13:03:21] INFO  ruby 1.9.3 (2011-10-30) [x86_64-darwin11.2.0]
[2012-02-16 13:03:21] INFO  WEBrick::HTTPServer#start: pid=69469 port=3000
{% endhighlight %}

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
    <span class="Apple-style-span" style="line-height: 18px;">Maintenant que je suis convaincu de passer à autre chose <img src="/images/smilies/simple-smile.png" alt=":)" class="wp-smiley" style="height: 1em; max-height: 1em;" /> :</span>
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
