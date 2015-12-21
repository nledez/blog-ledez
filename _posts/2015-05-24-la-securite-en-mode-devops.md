---
id: 2405
title: La sécurité en mode devops
author: Nicolas Ledez
layout:
  - default
guid: http://blog.ledez.net/?p=2405
permalink: /informatique/devops/la-securite-en-mode-devops/
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
  - DevOps
tags:
  - devops
  - Sécurité
---
Ce week-end, je me suis fait interpeler par mon copain [@jpgaulier][1] :

<div class="post-embed">
  <blockquote class="twitter-tweet" width="500">
    <p lang="en" dir="ltr">
      <a href="https://twitter.com/nledez">@nledez</a> <a href="https://twitter.com/MyCozyCloud">@MyCozyCloud</a> About security in devops, how do u manage it? s.t. about automation & tests & high skills?
    </p>
    
    <p>
      &mdash; JP Gaulier (@jpgaulier) <a href="https://twitter.com/jpgaulier/status/602044072757481472">May 23, 2015</a>
    </p>
  </blockquote>
  
  <p>
    </div> 
    
    <p>
      Et c&rsquo;est une super idée d&rsquo;article <img src="https://blog.ledez.net/wp-includes/images/smilies/simple-smile.png" alt=":)" class="wp-smiley" style="height: 1em; max-height: 1em;" />
    </p>
    
    <p>
      <a href="http://blog.ledez.net/wp-content/uploads/2015/05/lxfsm.jpg"><img class="alignnone wp-image-2408 size-medium" src="http://blog.ledez.net/wp-content/uploads/2015/05/lxfsm-300x209.jpg" alt="devops sécurité" width="300" height="209" srcset="http://blog.ledez.net/wp-content/uploads/2015/05/lxfsm-300x209.jpg 300w, http://blog.ledez.net/wp-content/uploads/2015/05/lxfsm.jpg 490w" sizes="(max-width: 300px) 100vw, 300px" /></a>
    </p>
    
    <p>
      <!--more-->
    </p>
    
    <p>
      Donc, je me suis dit &laquo;&nbsp;comment répondre à cette question&nbsp;&raquo;.
    </p>
    
    <p>
      Sans vous refaire l&rsquo;histoire de devops (Internet est là pour ça <img src="https://blog.ledez.net/wp-includes/images/smilies/simple-smile.png" alt=":)" class="wp-smiley" style="height: 1em; max-height: 1em;" /> ), on trouve dans la littérature qui parle du sujet l&rsquo;acronyme suivant :
    </p>
    
    <p>
      CAMS pour Culture, Automation, Measurement and Sharing
    </p>
    
    <p>
      Culture, Automatisation, Mesures et (S)Partage en français dans le texte.
    </p>
    
    <p>
      <strong>Mise en situation</strong>
    </p>
    
    <p>
      Je vais donc traiter le sujet sous ces 4 angles-là. Et comme je pratique tout cela chez <a href="https://twitter.com/MyCozyCloud">CozyCloud</a>, je vais vous expliquer comment nous traitons du sujet &laquo;&nbsp;chez nous&nbsp;&raquo;.
    </p>
    
    <p>
      Déjà, nous sommes une startup dont vous pourrez trouver plus d&rsquo;information sur le site <a href="http://cozy.io/">http://cozy.io/</a>.
    </p>
    
    <p>
      Mais en gros, nous développons une solution open source de cloud personnel. Vous pouvez <a href="http://cozy.io/host/install.html">l&rsquo;installer chez vous</a>, ou <a href="http://cozy.io/">nous demander une instance de bêta</a>, et à venir une instance chez l&rsquo;hébergeur de votre choix.
    </p>
    
    <p>
      Et j&rsquo;ai été embauché chez Cozy pour automatiser ces deux derniers types d&rsquo;installations.
    </p>
    
    <p>
      Et ceux qui me connaissent savent que je considère la sécurité comme <strong>un</strong> des éléments du système d&rsquo;informations. Et c&rsquo;est le cas chez Cozy. La sécurité est un élément très important (nous stockons les données de nos clients).
    </p>
    
    <p>
      Petite précision. Plus tard, quand je vais parler d’utilisateurs, ce sont les employés de Cozy.
    </p>
    
    <p>
      Bref, comment ça se passe chez nous.
    </p>
    
    <p>
      <strong>Culture</strong>
    </p>
    
    <p>
      Pour moi, c&rsquo;est là que se joue tout. En effet, nous pourrons faire tout ce que l&rsquo;on veut au niveau technique. Si un utilisateur donne son mot de passe à tout le monde, c&rsquo;est pour moi le plus gros trou de sécurité. Mais à un moment, il faut bien travailler. Je suis donc pour faire confiance à tout le monde.
    </p>
    
    <p>
      Mais comme de grands pouvoirs impliquent de grandes responsabilités, je demande aux utilisateurs d&rsquo;être vigilants par rapport aux accès.
    </p>
    
    <ul>
      <li>
        Il faut utiliser des vrais passphrases
      </li>
      <li>
        Les mots de passe doivent être stockés de manière chiffrée dans des outils comme Keepass ou autre
      </li>
      <li>
        Les clés SSH doivent avoir une passphase, et gardés privés
      </li>
    </ul>
    
    <p>
      Et plein d&rsquo;autres bonnes pratiques dans le même style.
    </p>
    
    <p>
      <strong>Automatisation</strong>
    </p>
    
    <p>
      Nous utilisons des outils comme <a href="http://saltstack.com/">Saltstack</a>, <a href="http://rundeck.org/">Rundeck</a>, etc.
    </p>
    
    <p>
      Pour salt, cela permet d&rsquo;automatiser les mises à jour. Avec Rundeck, de donner accès à des taches d&rsquo;automatisation à des utilisateurs sans leur donner accède à des machines.
    </p>
    
    <p>
      Un exemple avec Rundeck, je donne la possibilité aux utilisateurs, de récupérer la liste des applications installées et leurs versions. Mais aussi de déployer une nouvelle instance et tout cela sans me le demander. Ni sans donner accès à des parties sensibles de l&rsquo;infrastructure. Parce que je fais confiance, mais jusqu&rsquo;à un certain point <img src="https://blog.ledez.net/wp-includes/images/smilies/simple-smile.png" alt=":)" class="wp-smiley" style="height: 1em; max-height: 1em;" />
    </p>
    
    <p>
      Ensuite avec salt, cela me permet d&rsquo;automatiser des audits ou des mises à jour.
    </p>
    
    <p>
      Quand il y a une faille sur un produit que nous utilisons, je regarde quelles sont les versions de paquets installés dans notre parc. Puis je lance les mises à jour.
    </p>
    
    <p>
      <strong>Mesures</strong>
    </p>
    
    <p>
      Qu&rsquo;est-ce que l&rsquo;on peut bien mesurer ?
    </p>
    
    <p>
      Mais surtout avec quoi ?
    </p>
    
    <p>
      J&rsquo;utilise <a href="http://shinken-monitoring.org/">Shinken</a> depuis quelques années. Et cela me permet de lancer des tests sur des éléments de l&rsquo;infrastructure et de remonter des alertes quand quelque chose ne va pas.
    </p>
    
    <p>
      Ce que je surveille sur la partie sécurité (c&rsquo;est un peu le sujet du billet) :
    </p>
    
    <ul>
      <li>
        Disponibilité quand est-ce que le service est disponible. Mais surtout être alerté quand il ne l&rsquo;est plus.
      </li>
      <li>
        Intégrité, j&rsquo;utilise souvent des mots clés dans les pages des serveurs que je surveille
      </li>
      <li>
        Et j&rsquo;ajoute aussi la surveillance des backups. Comme cela, j&rsquo;ai tous mes problèmes en cours dans une seule vue
      </li>
    </ul>
    
    <p>
      <strong>Partage</strong>
    </p>
    
    <p>
      Et bien là, j&rsquo;écris des articles de blog <img src="https://blog.ledez.net/wp-includes/images/smilies/simple-smile.png" alt=":)" class="wp-smiley" style="height: 1em; max-height: 1em;" />
    </p>
    
    <p>
      Qu&rsquo;en pense tu JPG ?
    </p>

 [1]: https://twitter.com/jpgaulier/