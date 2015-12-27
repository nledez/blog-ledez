---
id: 1036
title: 'Rapman &#8211; libération &#8211; premiers pas'
author: Nicolas Ledez
layout: post
guid: http://blog.ledez.net/?p=1036
permalink: /diy/impression3d/rapman/rapman-liberation-premiers-pas/
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
  - Rapman
excerpt_separator: <!--more-->
---
  1. Trouver une alimentation électrique
  2. Faire marcher l&rsquo;alimentation électrique
  3. Identifier les câbles des fins de courses, moteurs, thermistance, résistance chauffante
  4. Câbler le capteur de température (sinon rien ne marche)
  5. Télécharger et configurer Marlin/Repetier
  6. Câbler les capteurs fins de course
  7. Tester les fins de courses (M119)
  8. Câbler les moteurs pas à pas
  9. Tester les moteurs pas à pas

<!--more-->

### Télécharger le firmware Repetier

Pour le firmware Repetier : <http://www.repetier.com/firmware/v091/>

Vous pouvez prendre le fichier de configuration :  
[Configuration.h][1]

Ou le fichier json pour le configurateur :  
[config.json][2]

<p class="p1">
  Profitez-en pour récupérer Repetier host (Windows, Mac ou Linux).
</p>

### L&rsquo;alimentation électrique

Il faut prendre une alimentation de PC classique.

<p class="p1">
  Et pour faire marcher une alim AT, il faut faire un peu de câblage :
</p>

<div id="attachment_1042" style="width: 310px" class="wp-caption alignnone">
  <a href="http://blog.ledez.net/wp-content/uploads/2014/05/2014-05-19-12.59.44.jpg"><img class="size-medium wp-image-1042" src="http://blog.ledez.net/wp-content/uploads/2014/05/2014-05-19-12.59.44-300x225.jpg" alt="Cablage d'alim AT" width="300" height="225" srcset="http://blog.ledez.net/wp-content/uploads/2014/05/2014-05-19-12.59.44-300x225.jpg 300w, http://blog.ledez.net/wp-content/uploads/2014/05/2014-05-19-12.59.44-1024x768.jpg 1024w" sizes="(max-width: 300px) 100vw, 300px" /></a>
  
  <p class="wp-caption-text">
    Cablage d&rsquo;alim AT
  </p>
</div>

Comme ça, elle se met en marche toute seule.

<p class="p1">
  Un peu de soudure et on branche comme ça :
</p>

<div id="attachment_1043" style="width: 310px" class="wp-caption alignnone">
  <a href="http://blog.ledez.net/wp-content/uploads/2014/05/2014-05-19-12.57.25.jpg"><img class="size-medium wp-image-1043" src="http://blog.ledez.net/wp-content/uploads/2014/05/2014-05-19-12.57.25-300x225.jpg" alt="Le connecteur molex femelles" width="300" height="225" srcset="http://blog.ledez.net/wp-content/uploads/2014/05/2014-05-19-12.57.25-300x225.jpg 300w, http://blog.ledez.net/wp-content/uploads/2014/05/2014-05-19-12.57.25-1024x768.jpg 1024w" sizes="(max-width: 300px) 100vw, 300px" /></a>
  
  <p class="wp-caption-text">
    Le connecteur molex femelles
  </p>
</div>

### Identification des fils

[<img class="alignnone size-medium wp-image-1044" src="http://blog.ledez.net/wp-content/uploads/2014/05/2014-05-19-13.30.57-300x225.jpg" alt="2014-05-19 13.30.57" width="300" height="225" srcset="http://blog.ledez.net/wp-content/uploads/2014/05/2014-05-19-13.30.57-300x225.jpg 300w, http://blog.ledez.net/wp-content/uploads/2014/05/2014-05-19-13.30.57-1024x768.jpg 1024w" sizes="(max-width: 300px) 100vw, 300px" />][3]

<div id="attachment_1045" style="width: 235px" class="wp-caption alignnone">
  <a href="http://blog.ledez.net/wp-content/uploads/2014/05/2014-05-19-13.31.16.jpg"><img class="size-medium wp-image-1045" src="http://blog.ledez.net/wp-content/uploads/2014/05/2014-05-19-13.31.16-225x300.jpg" alt="Les capteurs de fin de course" width="225" height="300" srcset="http://blog.ledez.net/wp-content/uploads/2014/05/2014-05-19-13.31.16-225x300.jpg 225w, http://blog.ledez.net/wp-content/uploads/2014/05/2014-05-19-13.31.16-768x1024.jpg 768w" sizes="(max-width: 225px) 100vw, 225px" /></a>
  
  <p class="wp-caption-text">
    Les capteurs de fin de course
  </p>
</div>

<p class="p1">
  Si vous avez suivi, les couleurs des câbles permettent d&rsquo;identifier les axes (X, Y et Z).
</p>

<p class="p1">
  Ca permet de faire cela :
</p>

<div id="attachment_1046" style="width: 235px" class="wp-caption alignnone">
  <a href="http://blog.ledez.net/wp-content/uploads/2014/05/2014-05-19-13.30.46.jpg"><img class="size-medium wp-image-1046" src="http://blog.ledez.net/wp-content/uploads/2014/05/2014-05-19-13.30.46-225x300.jpg" alt="Les prises par axes" width="225" height="300" srcset="http://blog.ledez.net/wp-content/uploads/2014/05/2014-05-19-13.30.46-225x300.jpg 225w, http://blog.ledez.net/wp-content/uploads/2014/05/2014-05-19-13.30.46-768x1024.jpg 768w" sizes="(max-width: 225px) 100vw, 225px" /></a>
  
  <p class="wp-caption-text">
    Les prises par axes
  </p>
</div>

### **Le schéma de câblage** {.p1}

Est ici <http://reprap.org/mediawiki/images/6/6d/Rampswire14.svg>

### Le capteur de température

Maintenant, du câblage/soudure :

<div id="attachment_1047" style="width: 235px" class="wp-caption alignnone">
  <a href="http://blog.ledez.net/wp-content/uploads/2014/05/2014-05-19-14.05.38.jpg"><img class="size-medium wp-image-1047" src="http://blog.ledez.net/wp-content/uploads/2014/05/2014-05-19-14.05.38-225x300.jpg" alt="Branchement d'un fin de course" width="225" height="300" srcset="http://blog.ledez.net/wp-content/uploads/2014/05/2014-05-19-14.05.38-225x300.jpg 225w, http://blog.ledez.net/wp-content/uploads/2014/05/2014-05-19-14.05.38-768x1024.jpg 768w" sizes="(max-width: 225px) 100vw, 225px" /></a>
  
  <p class="wp-caption-text">
    Branchement d&rsquo;un fin de course
  </p>
</div>

<p class="p1">
  C&rsquo;est le câble de droite. Pour l&rsquo;identifier, j&rsquo;ai utilisé une méthode empirique :
</p>

<p class="p1">
  2 paires de câbles viennent de l&rsquo;extrudeur :
</p>

[<img class="alignnone size-medium wp-image-1049" src="http://blog.ledez.net/wp-content/uploads/2014/05/2014-05-19-13.31.08-225x300.jpg" alt="2014-05-19 13.31.08" width="225" height="300" srcset="http://blog.ledez.net/wp-content/uploads/2014/05/2014-05-19-13.31.08-225x300.jpg 225w, http://blog.ledez.net/wp-content/uploads/2014/05/2014-05-19-13.31.08-768x1024.jpg 768w" sizes="(max-width: 225px) 100vw, 225px" />][4]

La paire grise, est la violette. Comme le gris est du gros fil, je me dis que c&rsquo;est la résistance chauffante. Et que la violette est le capteur de température.

<p class="p1">
  J&rsquo;ai donc câblé la violette.
</p>

### Vérification dans Repetier-Host

<p class="p1">
  On démarre le logiciel, connecte le driver.
</p>

<div id="attachment_1048" style="width: 305px" class="wp-caption alignnone">
  <a href="http://blog.ledez.net/wp-content/uploads/2014/05/by-default-2014-05-19-at-17.21.20-copy.png"><img class="size-medium wp-image-1048" src="http://blog.ledez.net/wp-content/uploads/2014/05/by-default-2014-05-19-at-17.21.20-copy-295x300.png" alt="Dans Repetier" width="295" height="300" srcset="http://blog.ledez.net/wp-content/uploads/2014/05/by-default-2014-05-19-at-17.21.20-copy-295x300.png 295w, http://blog.ledez.net/wp-content/uploads/2014/05/by-default-2014-05-19-at-17.21.20-copy.png 631w" sizes="(max-width: 295px) 100vw, 295px" /></a>
  
  <p class="wp-caption-text">
    Dans Repetier
  </p>
</div>

<p class="p1">
  La température ambiante doit s&rsquo;afficher dans le bas de la fenêtre.
</p>

### La resistance chauffante {.p1}

Il ne reste qu&rsquo;a faire la même chose pour la résistance chauffante. Et la cabler sur D10.

Pour les thermistances, il faut mettre :

{% highlight c %}
#define TEMP_SENSOR_0 2
#define TEMP_SENSOR_1 0
#define TEMP_SENSOR_2 0
#define TEMP_SENSOR_BED 0
{% endhighlight %}

Seul le capteur de température de l&rsquo;extruder est présent.

Ouvrir Repetier et vérifier que la température est présente.

### Faire monter en température

<p class="p1">
  Dans Repetier host, cliquer sur &laquo;&nbsp;Heat On&nbsp;&raquo;. La température doit monter jusqu&rsquo;à la valeur réglée.
</p>

### **Câblage des fins de course** {.p1}

<p class="p1">
  C&rsquo;est des capteurs fins de course classiques. Il faut juste les câbler au bon endroit sur la carte. Voir le schéma de montage.
</p>

### Test dans Repetier {.p1}

<p class="p1">
  Il faut cliquer sur &laquo;&nbsp;Toggle Log&nbsp;&raquo;, puis sur l&rsquo;onglet GCode. Dans la partie de droite, il faut taper &laquo;&nbsp;M119&nbsp;&raquo; puis valider avec la touche entrée. Les états des différents capteurs vont s&rsquo;afficher (j&rsquo;ai oublié le noter ce que ça marquait. Je mettrais l&rsquo;article à jour plus tard).
</p>

<p class="p1">
  Ensuite, appuyez sur X et refaire le GCode M119, regarder si X à changé d&rsquo;état, puis reproduire le test sur Y et Z.
</p>

### Câblage des moteurs {.p1}

<p class="p1">
  Les moteurs pas à pas ont 4 fils :
</p>

<div id="attachment_1051" style="width: 235px" class="wp-caption alignnone">
  <a href="http://blog.ledez.net/wp-content/uploads/2014/05/2014-05-19-15.06.09.jpg"><img class="size-medium wp-image-1051" src="http://blog.ledez.net/wp-content/uploads/2014/05/2014-05-19-15.06.09-225x300.jpg" alt="Les fils du moteur pas à pas" width="225" height="300" srcset="http://blog.ledez.net/wp-content/uploads/2014/05/2014-05-19-15.06.09-225x300.jpg 225w, http://blog.ledez.net/wp-content/uploads/2014/05/2014-05-19-15.06.09-768x1024.jpg 768w" sizes="(max-width: 225px) 100vw, 225px" /></a>
  
  <p class="wp-caption-text">
    Les fils du moteur pas à pas
  </p>
</div>

<p class="p1">
  Je les ai simplement recâblés sur un adaptateur.
</p>

### Test dans Repetier {.p1}

<p class="p1">
  Simplement brancher les moteurs un par un (X, Y puis Z mais l&rsquo;ordre importe peu).
</p>

### Test dans Repetier {.p1}

<p class="p1">
  Et dans le logiciel, ouvrez l&rsquo;onglet &laquo;&nbsp;Print Panel&nbsp;&raquo;. Essayez de déplacer le chariot en commençant par les petites valeurs (0.1, -0.1), puis en augmentant petit à petit.
</p>

### Câblage du pas-à-pas de l&rsquo;extrudeur {.p1}

<p class="p1">
  Si vous avez réussi X, Y et Z c&rsquo;est la même chose.
</p>

### Test dans Repetier {.p1}

<p class="p1">
  Dans l&rsquo;onglet &laquo;&nbsp;Print Panel&nbsp;&raquo; le groupe &laquo;&nbsp;Extruder&nbsp;&raquo;, cliquer sur &laquo;&nbsp;Heat On&nbsp;&raquo; que le bouton s&rsquo;allume.
</p>

<p class="p1">
  Une fois à la bonne température pour le plastique (ABS, PLA, etc). Cliquer sur Extrude, Retract. Un peu de plastique devrait sortir de la buse.
</p>

### Ventilateur {.p1}

<p class="p1">
  Je l&rsquo;ai cablé sur D09 et pour le test, vous avez compris comment ça marche <img src="smilies/simple-smile.png" alt=":)" class="wp-smiley" style="height: 1em; max-height: 1em;" />
</p>

### Ressources {.p1}

<p class="p1">
  Le Wiki de la RAMPS : <a href="http://reprap.org/wiki/RAMPS_1.4">http://reprap.org/wiki/RAMPS_1.4</a>
</p>

<p class="p1">
  Le schema de câblage de la RAMPS : <a href="http://reprap.org/mediawiki/images/6/6d/Rampswire14.svg">http://reprap.org/mediawiki/images/6/6d/Rampswire14.svg</a>
</p>

<p class="p1">
  Le site de Repetier : <a href="http://www.repetier.com/">http://www.repetier.com/</a>
</p>

<p class="p1">
  Ou j&rsquo;ai trouvé l&rsquo;inspiration pour le ventilateur : <a href="http://forums.reprap.org/read.php?219,284204">http://forums.reprap.org/read.php?219,284204</a>
</p>

<p class="p1">
  Avoir une idée de comment cabler l&rsquo;alimentation AT(X) : <a href="http://www.mp3car.com/the-faq-emporium/84681-faq-how-do-i-power-my-dc-dc-psu-on-my-workbench.html">http://www.mp3car.com/the-faq-emporium/84681-faq-how-do-i-power-my-dc-dc-psu-on-my-workbench.html</a>
</p>

<p class="p1">
  Et l&rsquo;image qui résume tout : <a href="http://www.mp3car.com/vbulletin/imagehosting/382984622294e08fc5.gif">http://www.mp3car.com/vbulletin/imagehosting/382984622294e08fc5.gif</a>
</p>

<p class="p1">
  Le LabFab de Rennes : <a href="http://www.labfab.fr/">http://www.labfab.fr/</a>
</p>

<p class="p1">
  L&rsquo;imprimante de <span style="color: #444444;">Philippe : <a href="http://www.labfab.fr/portfolio/pakbot/">http://www.labfab.fr/portfolio/pakbot/</a></span>
</p>

### Remerciements {.p1}

<p class="p1">
  Samir de m&rsquo;avoir fait confiance pour réparer son imprimante.
</p>

<p class="p1">
  Philippe pour le prêt de sa RAMPS + l&rsquo;Arduino Mega + de quoi câbler tout ça.
</p>

### Conlusion {.p1}

<p class="p1">
  Il me manque un driver pas à pas (que Philippe devrait me faire passer dans la semaine). Et je devrais pouvoir commencer à régler tout ça sous peu.
</p>

 [1]: http://blog.ledez.net/wp-content/uploads/2014/05/Configuration.h.txt
 [2]: http://blog.ledez.net/wp-content/uploads/2014/05/config.json_.txt
 [3]: http://blog.ledez.net/wp-content/uploads/2014/05/2014-05-19-13.30.57.jpg
 [4]: http://blog.ledez.net/wp-content/uploads/2014/05/2014-05-19-13.31.08.jpg
