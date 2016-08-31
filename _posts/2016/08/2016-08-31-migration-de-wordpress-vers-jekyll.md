---
title: Migration de Wordpress vers Jekyll
lang: fr
layout: post
permalink: /migration-de-wordpress-vers-jekyll/
categories: [ Blog ]
tags:  [ jekyll blog ]
excerpt_separator: <!--more-->
---
![Wordpress to Jekyll]({{ site.url }}/images/2016/08/wordpress-2-jekyll.png)

J'ai migré ce blog de [Wordpress](https://wordpress.org/) à [Jekyll](https://jekyllrb.com/).

Je voulais :

* Reprendre tous les contenus, articles et pages
* Ne pas perdre les commentaires
* Garder toutes les URL existantes
* Passer à quelque chose de statique
* Versionner tout ça dans [Git](https://git-scm.com/)
* Écrire tout ça dans un format style [Markdown](https://fr.wikipedia.org/wiki/Markdown)

<!--more-->

Alors, pour poser le décor, j'ai quand même mis un an à trouver le temps de migrer tout ça...

Et j'entends déjà mon pote [Fred](https://twitter.com/fredericalix) me dire que j'aurais pu utiliser [Hugo](https://gohugo.io/). Mais je voulais terminer pendant mes vacances. J'ai donc tout de même fini ma migration vers [Jekyll](https://jekyllrb.com/).

J'ai procédé de la manière suivante :

* Migration des commentaires dans [Disqus](https://disqus.com/) avec [la bonne procédure](https://help.disqus.com/customer/portal/articles/466255-importing-comments-from-wordpress)
* Export de tout mon blog avec [Jekyll Exporter](https://wordpress.org/plugins/jekyll-exporter/)
* À grands coups de [sed](https://fr.wikipedia.org/wiki/Stream_Editor), modification de certaines URL
* Vérification des images manquantes
* Et pleins d'autres trucs que j'ai oubliés ^^
