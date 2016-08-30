---
id: 2459
title: 'Size doesn&rsquo;t matter (enfin, c&rsquo;est ce qu&rsquo;il se dit)'
author: Nicolas Ledez
layout: post
guid: http://blog.ledez.net/?p=2459
permalink: /informatique/devops/size-doesnt-matter/
dsq_thread_id:
  - 4820384546
categories:
  - Conférences
  - DevOps
tags:
  - devops
excerpt_separator: <!--more-->
---
Cette semaine je suis intervenu en keynote lors de l&rsquo;[OVH world tour à Rennes](https://www.ovh.com/fr/events/RS10052016rennes-ovh-world-tour-rennes) :

{% twitter oembed https://twitter.com/BrenAbolivier/status/729955713464840192 %}

Et j&rsquo;ai pris conscience de quelque chose&#8230;

<!--more-->

Chez <a href="https://twitter.com/MyCozyCloud">Cozy Cloud</a> nous sommes pour le moment 2 administrateurs système.

Et pourtant, nous gérons au quotidien entre 2000 et 3000 &laquo;&nbsp;machines&nbsp;&raquo;. Dont une trentaine de serveurs physiques.

Ce n&rsquo;est visiblement pas si commun que cela ![:)]({{ site.url }}/images/smilies/simple-smile.png){:style="height: 1em; max-height: 1em;"}

Et comment nous en sommes arrivés à cela :
* Utilisation de <a href="https://docs.saltstack.com/en/latest/">SaltStack</a> qui permet de gérer beaucoup de machines
* Mais aussi de son <a href="https://docs.saltstack.com/en/latest/ref/clients/index.html">API Python</a> qui permet d&rsquo;automatiser encore plus
    
Et tout cela en moins de 2 ans (je vais fêter l&rsquo;anniversaire de mon arrivée dans l&rsquo;entreprise en aout).

Pour l&rsquo;anecdote j&rsquo;ai quelques soucis de charges sur certains services comme <a href="http://shinken.io/">Shinken</a>, <a href="https://docs.saltstack.com/en/latest/">SaltStack</a>, etc.

Et à chaque fois, je me dis &laquo;&nbsp;je ne comprends pas pourquoi cela ne fonctionne pas. Je n&rsquo;ai que 2000 machines&#8230;&nbsp;&raquo;.
    
Voilà, c&rsquo;est tout ce que je voulais vous dire. Mais ça ne tenait pas dans 140 caractères ^^
