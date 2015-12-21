---
id: 336
title: Array ruby tricks
author: Nicolas Ledez
layout: post
guid: http://blog.ledez.net/?p=336
permalink: /informatique/array-ruby-tricks/
categories:
  - Informatique
  - Ruby
  - Tips
tags:
  - array
  - ruby
  - tips
---
J&rsquo;en ai parlé lors de ma session aux MS Techdays.

On vous donne 2 fichiers :

  * Le fichier avec les UUID à enlever
  * Le fichier avec tous les UUID

Le chalenge, ne garder que les UUID absent :p

Les armes :

  * Ruby
  * Ben&#8230; c&rsquo;est tout

<!--more-->

<div class="codecolorer-container ruby default" style="overflow:auto;white-space:nowrap;">
  <div class="ruby codecolorer">
    <span class="co1"># Initialisation des variables, je vais utiliser 2 tableaux</span><br /> remove = <span class="br0">&#91;</span><span class="br0">&#93;</span><br /> <br /> <span class="co1"># J'ouvre les fichiers, et pour chaque ligne la pousser dans son tableau.</span><br /> <span class="co1"># Pour l'exemple, j'utilise 2 méthodes pour remplir les tableaux</span><br /> all = <span class="kw4">File</span>.<span class="kw3">readlines</span><span class="br0">&#40;</span><span class="st0">"01-all.csv"</span><span class="br0">&#41;</span><br /> <span class="kw4">File</span>.<span class="kw3">open</span><span class="br0">&#40;</span><span class="st0">"02-to-remove.csv"</span><span class="br0">&#41;</span>.<span class="me1">each</span> <span class="br0">&#123;</span> <span class="sy0">|</span>l<span class="sy0">|</span> remove <span class="sy0"><<</span> l <span class="br0">&#125;</span><br /> <br /> <span class="co1"># Afficher le nombre d'éléments dans chaque tableau</span><br /> <span class="kw3">puts</span> <span class="st0">"All: #{all.count}"</span><br /> <span class="kw3">puts</span> <span class="st0">"Remove: #{remove.count}"</span><br /> <br /> <span class="co1"># La partie intéressante : la soustraction</span><br /> keep = all <span class="sy0">-</span> remove<br /> <br /> <span class="co1"># J'affiche le nombre d'éléments dans le tableau restant</span><br /> <span class="kw3">puts</span> <span class="st0">"Keep: #{keep.count}"</span><br /> <br /> <span class="co1"># Et vérifie si le nombre d'éléments correspond à ce que je voudrais</span><br /> <span class="kw3">puts</span> <span class="st0">"Groovy !!!"</span> <span class="kw1">if</span> keep.<span class="me1">count</span> == <span class="br0">&#40;</span>all.<span class="me1">count</span> <span class="sy0">-</span> remove.<span class="me1">count</span><span class="br0">&#41;</span><br /> <br /> <span class="co1"># J'enregistre le résultat dans un fichier</span><br /> file = <span class="kw4">File</span>.<span class="kw3">open</span><span class="br0">&#40;</span><span class="st0">"03-to-keep.csv"</span>, <span class="st0">"w+"</span><span class="br0">&#41;</span><br /> keep.<span class="me1">each</span> <span class="br0">&#123;</span> <span class="sy0">|</span>lun<span class="sy0">|</span> file.<span class="kw3">puts</span> lun <span class="br0">&#125;</span><br /> file.<span class="me1">close</span>
  </div>
</div>

Le résultat :

<div class="codecolorer-container text default" style="overflow:auto;white-space:nowrap;">
  <div class="text codecolorer">
    All: 31<br /> Remove: 7<br /> Keep: 24<br /> Groovy !!!
  </div>
</div>

La version courte de &laquo;&nbsp;prod&nbsp;&raquo; :

<div class="codecolorer-container ruby default" style="overflow:auto;white-space:nowrap;">
  <div class="ruby codecolorer">
    remove = <span class="br0">&#91;</span><span class="br0">&#93;</span><br /> <br /> all = <span class="kw4">File</span>.<span class="kw3">readlines</span><span class="br0">&#40;</span><span class="st0">"01-all.csv"</span><span class="br0">&#41;</span><br /> <span class="kw4">File</span>.<span class="kw3">open</span><span class="br0">&#40;</span><span class="st0">"02-to-remove.csv"</span><span class="br0">&#41;</span>.<span class="me1">each</span> <span class="br0">&#123;</span> <span class="sy0">|</span>l<span class="sy0">|</span> remove.<span class="me1">push</span> l <span class="br0">&#125;</span><br /> <br /> keep = all <span class="sy0">-</span> remove<br /> <br /> file = <span class="kw4">File</span>.<span class="kw3">open</span><span class="br0">&#40;</span><span class="st0">"03-to-keep.csv"</span>, <span class="st0">"w+"</span><span class="br0">&#41;</span><br /> keep.<span class="me1">each</span> <span class="br0">&#123;</span> <span class="sy0">|</span>lun<span class="sy0">|</span> file.<span class="kw3">puts</span> lun <span class="br0">&#125;</span><br /> file.<span class="me1">close</span>
  </div>
</div>

Si vous voulez générer des fichiers pour faire le test vous même :

<div class="codecolorer-container ruby default" style="overflow:auto;white-space:nowrap;">
  <div class="ruby codecolorer">
    all = <span class="kw4">File</span>.<span class="kw3">open</span><span class="br0">&#40;</span><span class="st0">"01-all.csv"</span>, <span class="st0">"w"</span><span class="br0">&#41;</span><br /> remove = <span class="kw4">File</span>.<span class="kw3">open</span><span class="br0">&#40;</span><span class="st0">"02-to-remove.csv"</span>, <span class="st0">"w"</span><span class="br0">&#41;</span><br /> <br /> <span class="br0">&#40;</span><span class="nu0"></span>..<span class="nu0">30</span><span class="br0">&#41;</span>.<span class="me1">each</span> <span class="kw1">do</span><br /> &nbsp; val = <span class="kw3">rand</span><span class="br0">&#40;</span><span class="nu0">10000000000000</span><span class="br0">&#41;</span><br /> &nbsp; all.<span class="kw3">puts</span> val<br /> &nbsp; remove.<span class="kw3">puts</span> val <span class="kw1">if</span> <span class="kw3">rand</span><span class="br0">&#40;</span><span class="nu0">5</span><span class="br0">&#41;</span> <span class="sy0">></span> <span class="nu0">3</span><br /> <span class="kw1">end</span><br /> <br /> remove.<span class="me1">close</span><br /> all.<span class="me1">close</span>
  </div>
</div>

Edit: Sur une suggestion de Ghislain, j&rsquo;ai modifié le code d&rsquo;exemple pour ajouter une variante plus courte