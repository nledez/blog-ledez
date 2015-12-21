---
id: 28
title: 'Ajax &#8211; introduction'
author: Nicolas Ledez
layout: post
guid: http://nicolas.ledez.free.fr/blog/?p=28
permalink: /divers/ajax-introduction/
categories:
  - Divers
  - Informatique
  - Web
---
Ajax mais qu&rsquo;est ce que c&rsquo;est ?

Une application web classique :

[http://nicolas.ledez.free.fr/dev/cnam/02\_calcul\_pphp.php][1]

A chaque fois que je veux le résultat, je dois cliquer, et je recharge la page à chaque fois. Interactivité 0 + 1,16 Ko à chaque fois que je charge la page (elle est très simple, donc légère, mais la page de mon blog fait déjà 10 fois plus).

Maintenant la même chose en Ajax :

[http://nicolas.ledez.free.fr/dev/cnam/03\_calcul\_ajax.php][2]

Maintenant à chaque fois que je change d&rsquo;opérateur ou d&rsquo;opérande, j&rsquo;ai le résultat en temps réel (ou presque). Cette fois ci, au niveau du réseau je n’ai que le résultat qui me revient. On ne compte donc plus en Ko mais en octets. Imaginez la différence si vous aviez eu ça à la belle époque du 56k (voir moins).

Maintenant comprenez-vous mieux l&rsquo;intérêt de faire de l&rsquo;Ajax ?

Si vous voulez voir les sources des 2 programmes, elles sont disponibles ici :

[http://nicolas.ledez.free.fr/?012_cnam.htm][3]

 [1]: http://nicolas.ledez.free.fr/dev/cnam/02_calcul_pphp.php
 [2]: http://nicolas.ledez.free.fr/dev/cnam/03_calcul_ajax.php
 [3]: http://nicolas.ledez.free.fr//?012_cnam.htm