---
id: 280
title: 'Comment j&rsquo;ai contribué à la communauté Open-Source cette année'
author: Nicolas Ledez
layout: post
guid: http://blog.ledez.net/?p=280
permalink: /blog/comment-jai-contribue-a-la-communaute-open-source-cette-annee/
categories:
  - Blog
  - OpenSource
tags:
  - auto-entrepreneur
  - communauté
  - open-source
excerpt_separator: <!--more-->
---
Suite au [Breizhcamp][1], son sondage et tout ça, je me suis demandé comment j&rsquo;ai contribué récemment aux différentes communautés.

Dans le temps j&rsquo;ai été mainteneur de paquets [Debian][2]. C&rsquo;était l&rsquo;époque ou je développais sous [Zope][3].

Depuis je me suis occupé autrement, j&rsquo;ai géré un peu plus efficacement ma carrière. J&rsquo;ai monté ma boite en temps qu&rsquo;auto-entrepreneur.

De temps en temps je réalisais des présentations dans des thèmes informatiques. Par exemple, la virtualisation a [Granit][4].

Puis il y a environ 2 ans j&rsquo;ai voulu me mettre plus sérieusement à [Ruby On Rails][5]. J&rsquo;ai entendu parlé de [Rennes On Rails][6]. J&rsquo;y suis allé à un moment ou le groupe était en perte de vitesse. [Karine][7] qui s&rsquo;occupait du groupe était de plus en plus prise avec le projet de la [Cantine][8].

Je lui est proposé de reprendre l&rsquo;animation du groupe. Ce qu&rsquo;elle a bien sûr accepté en me proposant en plus d&rsquo;accueil le groupe à la [Cantine Numérique Rennaise][8].  
<!--more-->

  
J&rsquo;ai donc relancé le groupe avec mon retour d&rsquo;expérience avec ROR :

<div style="width:340px" id="__ss_8120437">
  <strong style="display:block;margin:12px 0 4px"><a href="http://www.slideshare.net/nledez/ruby-on-rails-6-mois-aprs" title="Ruby on Rails - 6 mois aprés">Ruby on Rails &#8211; 6 mois aprés</a></strong> 
  
  <div style="padding:5px 0 12px">
    View more <a href="http://www.slideshare.net/">presentations</a> from <a href="http://www.slideshare.net/nledez">Nicolas Ledez</a>
  </div></p>
</div>

Nous avons enchainé avec une install party.

Les deux événements ont amené pas mal de monde. 20 à 30 personnes pour un JUG, je pense que ce n&rsquo;est pas beaucoup. Mais pour ROR, c&rsquo;est énorme 😉

Ensuite avec le support de [Thierry][9], nous avons organisé des Coding-Dojo tous les mois. Avec un énorme succès (entre 2 et 7 personnes) :).

Voilà pour la partie Rennes On Rails.

Lors de l&rsquo;inauguration de la CNR, j&rsquo;ai croisé le président de [Granit][4] qui m&rsquo;a présenté Isabelle qui était la nouvelle Coordinatrice du réseau. Je leur ai proposé d&rsquo;ouvrir un thème sur le Cloud. Passage en Conseil d&rsquo;Administration, et c&rsquo;est parti pour un tour :

<div style="width:340px" id="__ss_8115435">
  <strong style="display:block;margin:12px 0 4px"><a href="http://www.slideshare.net/nledez/le-cloud-lintroduction" title="Le &quot;Cloud&quot; - L&#39;introduction">Le "Cloud" &#8211; L'introduction</a></strong> 
  
  <div style="padding:5px 0 12px">
    View more <a href="http://www.slideshare.net/">presentations</a> from <a href="http://www.slideshare.net/nledez">Nicolas Ledez</a>
  </div></p>
</div>

Ensuite [Nicolas][10], m&rsquo;a proposé de présenter le Cloud selon Microsoft. D&rsquo;autres thèmes sont à venir l&rsquo;année prochaine.

Voilà pour la partie Cloud à Granit.

Ensuite Karine, m&rsquo;a fait suivre une demande de [Nicolas Deloof][11] qui était un appel a speaker pour le [Breizhcamp][1]. Dans un premier temps, j&rsquo;ai proposé de refaire mon introduction au Cloud avec une démo d&rsquo;[Heroku][12]. Le créneau NoSQL pour Ruby ayant du mal à trouver preneur, je me suis lancé un petit défi de me proposer comme speaker pour cette session aussi. Me voila donc partit dans un rassemblement de 200 développeurs, et à proposer une session sur NoSQL dont je ne connaissais que 2/3 trucs théoriques. Et surtout avec le risque de me retrouver avec des personnes dans la salle qui connaissent le sujet plus que moi.

Voilà pour la partie Breizhcamp.

Maintenant petit retour en arrière. L&rsquo;année dernière, je voulais donc me mettre sérieusement à Ruby On Rails. Comme je l&rsquo;ai expliqué, Rennes On Rails ne m&rsquo;avait pas permis d&rsquo;avancer autant que je l&rsquo;espérais. Je me suis donc donné pour objectif d&rsquo;avoir une application fonctionnelle à la fin de mes 15 jours de vacances de juin. Je me suis donc pris une application à développer et me suis lancé. J&rsquo;ai épluché les différentes documentations sur le net. Mon application Rails (une gestion de médiathèque &#8211; je sais c&rsquo;est très original&#8230;) avançait, puis j&rsquo;ai eu besoin d&rsquo;ajouter une connexion avec le [scraper cine-passion][13]. Pas de chance, il n&rsquo;y avait pas de librairie Ruby. Je me suis donc lancé dans le développement de celle-ci. J&rsquo;ai découvert au passage [TDD][14] et [Github][15].

Et pour finir, j&rsquo;ai dans mes différents développements perso trouvés des bugs et besoins dans les produits que j&rsquo;utilisais. Et finalement plutôt que de demander et attendre j&rsquo;ai suis passé en mode &laquo;&nbsp;do it yourself&nbsp;&raquo;, ce qui a donné :  
&#8211; Proposition d&rsquo;évolution de Bundler pour gérer le multiplateforme [pull-request 1082][16]  
&#8211; Traduction de git initié par Sébastien Douche [pull request 2][17]  
&#8211; Et un but avec i18n et Rails 3.1 rc [pull request 97][18], pour régler un problème avec ma démo pour le Breizhcamp

Je vais essayer de me dégager un peu de temps pour finir mon path Bundler, et continuer à faire progresser ROR & le Cloud à Rennes.

Voila la fin de ce billet un peu fouillis qui m&rsquo;a permis de faire le point.

Je profite de ce billet pour remercier tous les personnes et groupes que j&rsquo;ai cités pour les remercier de leurs supports. Et à l&rsquo;année prochaine <img src="{{ site.url }}/images/smilies/simple-smile.png" alt=":)" class="wp-smiley" style="height: 1em; max-height: 1em;" />

 [1]: http://www.breizhcamp.org/
 [2]: http://www.debian.org/
 [3]: http://www.zope.org/
 [4]: http://www.granit.org/
 [5]: http://rubyonrails.org/
 [6]: http://www.rennesonrails.com/
 [7]: http://www.karinesabatier.net/
 [8]: http://www.lacantine-rennes.net/
 [9]: https://twitter.com/#!/thierryhenrio
 [10]: http://nicolasgt.exakis.com/
 [11]: http://blog.loof.fr/
 [12]: http://www.heroku.com/
 [13]: http://passion-xbmc.org/scraper-cine-passion-support-francais/
 [14]: http://www.rubyfrance.org/documentations/tdd/
 [15]: https://github.com/nledez/ruby-scraper-cine-passion
 [16]: https://github.com/carlhuda/bundler/pull/1082
 [17]: https://github.com/sdouche/git-french-translation/pull/2
 [18]: https://github.com/svenfuchs/i18n/pull/97
