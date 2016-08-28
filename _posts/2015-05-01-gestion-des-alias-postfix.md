---
id: 2382
title: Gestion des alias postfix
author: Nicolas Ledez
layout: post
guid: http://blog.ledez.net/?p=2382
permalink: /informatique/gestion-des-alias-postfix/
feature_size:
  - blank
hide_post_title:
  - default
unlink_post_title:
  - default
hide_post_meta:
  - default
hide_post_date:
  - default
hide_post_image:
  - default
unlink_post_image:
  - default
builder_switch_frontend:
  - 0
categories:
  - Informatique
tags:
  - alias
  - mail
  - postfix
excerpt_separator: <!--more-->
---
[<img class="alignnone size-medium wp-image-2385" src="{{ site.url }}/images/2015/05/Postfix_logo-300x159.png" alt="Postfix" width="300" height="159" />][1]Aujourd&rsquo;hui, j&rsquo;ai reçu un joli phishing sur mon adresse vinci-autoroutes@mon-domaine. C&rsquo;était un phishing pour le Crédit Agricole.

À priori, je dirais que c&rsquo;est un petit leak de base de données.

Et comme j&rsquo;ai tweeté :

<div class="post-embed">
  <blockquote class="twitter-tweet" width="500">
    <p lang="fr" dir="ltr">
      Bonjour <a href="https://twitter.com/VINCIAutoroutes">@VINCIAutoroutes</a>, vous vous êtes fait pirater votre base client ? Je viens de recevoir du phishing sur vinci-autoroutes@ledez.net
    </p>
    
    <p>
      &mdash; Nicolas Ledez (@nledez) <a href="https://twitter.com/nledez/status/594053414209851392">May 1, 2015</a>
    </p>
  </blockquote>
  
  <p>
    </div> 
    
    <p>
      J&rsquo;ai eu une demande sur comment je fais pour mes adresses mails &laquo;&nbsp;bidon&nbsp;&raquo; ou même personnalisés.
    </p>
    
    <p>
      Et comme ce n&rsquo;est pas la première fois ni la dernière, je pense&#8230;<br /> Je me suis dit que ce serait le moment de sortir ça en open source :
    </p>
    
    <p>
      <!--more-->
    </p>
    
    <p>
      Avant, j&rsquo;utilisais :
    </p>
    
    <p>
      <a href="https://github.com/nledez/aliases-scripts">https://github.com/nledez/aliases-scripts</a>
    </p>
    
    <p>
      Mais :
    </p>
    
    <ul>
      <li>
        Il me fallait une connexion SSH
      </li>
      <li>
        Vraiment pas pratique en déplacement
      </li>
      <li>
        Ou pire à la caisse du magasin quand on vous demande le mail pour la carte de fidélité
      </li>
    </ul>
    
    <p>
      J&rsquo;ai donc écrit un truc à l&rsquo;arrache :
    </p>
    
    <p>
      <a href="https://github.com/nledez/aliases-php">https://github.com/nledez/aliases-php</a>
    </p>
    
    <p>
      Attention, c’est surement :
    </p>
    
    <ul>
      <li>
        Pas adapté à votre besoin, car pas user friendly
      </li>
      <li>
        Pas fait pour être utilisé à plusieurs
      </li>
      <li>
        Pas toujours, pratique, par exemple pour désactiver un mail, il faut le faire en SQL
      </li>
    </ul>
    
    <p>
      Comme c&rsquo;est en open source, vous pouvez en faire ce que vous voulez. Mais attention, c&rsquo;est du je n&rsquo;ai-pas-le-temps-de-le maintenir-ware <img src="{{ site.url }}/images/smilies/simple-smile.png" alt=":)" class="wp-smiley" style="height: 1em; max-height: 1em;" />
    </p>

 [1]: https://blog.ledez.net/wp-content/uploads/2015/05/Postfix_logo.png
