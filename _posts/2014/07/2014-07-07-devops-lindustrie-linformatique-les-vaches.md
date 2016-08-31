---
id: 1132
title: 'DevOps, l&rsquo;industrie, l&rsquo;informatique et les vaches'
author: Nicolas Ledez
layout: post
guid: http://blog.ledez.net/?p=1132
permalink: /informatique/devops/devops-lindustrie-linformatique-les-vaches/
categories:
  - DevOps
excerpt_separator: <!--more-->
---
<p class="p1">
  Je sais vous allez vous dire c&rsquo;est quoi le rapport avec les vaches ?
</p>

<p class="p1">
  Laissez vous porter par l&rsquo;article et vous allez tout comprendre.<!--more-->
</p>

<p class="p1">
  Pour démarrer, je vais vous parler un peu de moi.
</p>

# Mon enfance

<p class="p1">
  Je suis né en Corrèze. Oui le pays de Chirac, les pommes, la verdure. À l&rsquo;époque Internet pour personne. Donc je l&rsquo;ai bien vécu <img src="{{ site.url }}/images/smilies/simple-smile.png" alt=":)" class="wp-smiley" style="height: 1em; max-height: 1em;" /> Mais comme j&rsquo;habitais à la campagne, j&rsquo;avais beaucoup de paysans autour de chez moi. Je me souviens que quand j&rsquo;étais petit tout le village aller aider le paysan à faire &laquo;&nbsp;le foin&nbsp;&raquo;. Et en échange, dans l&rsquo;année nous avions le droit d&rsquo;avoir un peu de lait produit par sa vingtaine de vaches. Ces moments de moisson étaient hyper conviviaux. Mais là, ce n&rsquo;est plus le sujet.
</p>

# Ma formation initiale

<p class="p1">
  Ensuite j&rsquo;ai déménagé en Saône et Loire ou j&rsquo;ai fait un BEP Maintenance des Systèmes Mécaniques Automatisés. En gros apprendre à faire la maintenance d&rsquo;une chaine de production industrielle. Pour des clients type Potain, PSA, etc. Et sur une chaine de production, la moindre interruption de service coute extrêmement cher (plusieurs dizaines de personnes au chômage technique). J&rsquo;ai donc appris à :
</p>

  * Faire de la maintenance proactive (pour éviter que cela ne tombe en panne)
  * Et la maintenance corrective (pour que la panne dure le moins longtemps possible)

<p class="p2">
  Mais finalement je me suis rendu compte que travailler à l&rsquo;usine ce n&rsquo;était pas mon truc. Je me suis aussi rendu compte que ma passion pour l&rsquo;informatique me donnait certaines facilités dans le domaine. J&rsquo;ai donc terminé mes études dans ce domaine. Je gérais en parallèle mon petit serveur Linux, DNS, DHCP, et ne ne sais plus quoi d&rsquo;autre, mais j&rsquo;ai fait mes armes sous Unix à la maison.
</p>

<p class="p2">
  Vous vous rappelez des vaches ? Et bien je vais vous en parler. Mais un peu plus tard.
</p>

# L&rsquo;arrivée dans le monde tu travail

<p class="p2">
  Donc j&rsquo;arrive dans le monde du travail à Rennes. Chez Equant dans le service du &laquo;&nbsp;Webhosting&nbsp;&raquo; dans le service dédié à France Telecom. Là, ça a changé :
</p>

  * Linux vers Solaris
  * Mysql vers Oracle
  * PHP vers Java et Websphere
  * Apache vers iPlanet

<p class="p2">
  Par contre, tout ça sur la même machine. Nous installions tout ça avec un joli manuel écrit dans Word, imprimé. Et moi j&rsquo;aimais bien cocher au fur et à mesure ce que j&rsquo;avais fait. Quand il y avait des erreurs, je les notais à la main puis reportais tout ça dans un mail au rédacteur du document. Une fois que ça marche en préproduction, je passe sur mon serveur de production. Oui vous avez bien compté :
</p>

  * Un administrateur système
  * 2 serveurs
  * Pour un seul projet

<p class="p2">
  Voir dans certains cas, nous mutualisions un maximum.
</p>

<p class="p2">
  Les vaches
</p>

<p class="p2">
  Et mes vaches dans tout ça ? Et bien j&rsquo;étais arrivé en Bretagne, la région de l&rsquo;agriculture intensive (avec ses bons et ses mauvais côtés).
</p>

<p class="p2">
  Donc un agriculteur ne gère plus 20 vaches, mais 100/200. Mais comment font-ils ? L&rsquo;industrialisation ! Ils ont des machines adaptées à chaque tache. Des sous traitants pour certaines parties.
</p>

<p class="p2">
  Le voilà donc le rapport avec les vaches ! Mais oui maintenant &laquo;&nbsp;dans mon garage&nbsp;&raquo; (c&rsquo;est pour des associations) avec du Puppet/Chef/Ansible/Saltstack/Scripts, je gère 180 serveurs. Et au final, je passe autant de temps qu&rsquo;avant à gérer ces serveurs.
</p>

# Automatisation !

<p class="p2">
  C&rsquo;est donc un excellent moyen de gérer ses machines plus facilement. En effet, si un problème est remonté sur une machine, on corrige la recette/script on déploie sur des machines de tests. Et si c&rsquo;est OK, on généralise sur tout le parc en quelques minutes/heures. Là ou auparavant il fallait des jours voir des mois. Idem pour MAJ de sécurités, etc.
</p>

<p class="p2">
  Là où cela risque de faire mal. C&rsquo;est le changement de métier des administrateurs système. Avant il suffisait de suivre un manuel, et si cela n&rsquo;était pas bon, remonter l&rsquo;information au rédacteur de la doc. Bon je caricature un peu. Mais ce qu&rsquo;il faut retenir c&rsquo;est que tout se faisait à la main machine par machine. Et que demain, il va falloir savoir écrire ces recettes/scripts.
</p>

<p class="p2">
  Et du coup, tout ce temps qui va être libéré va pouvoir être utilisé à faire cette fameuse maintenance proactive et réduire la maintenance curative. Vous allez donc améliorer la vie de votre plate-forme <img src="{{ site.url }}/images/smilies/simple-smile.png" alt=":)" class="wp-smiley" style="height: 1em; max-height: 1em;" />
</p>

<p class="p2">
  Et l&rsquo;automatisation est une des composantes de &laquo;&nbsp;DevOps&nbsp;&raquo;.
</p>

<p class="p1">
  Convaincu ?
</p>
