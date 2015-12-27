---
id: 2368
title: 'Check-list de sécurisation d&rsquo;un serveur'
author: Nicolas Ledez
layout: post
guid: http://blog.ledez.net/?p=2368
permalink: /informatique/check-list-de-securisation-dun-serveur/
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
post_image:
  - http://blog.ledez.net/wp-content/uploads/2015/04/Security_spikes_1.jpg
builder_switch_frontend:
  - 0
categories:
  - DevOps
  - Informatique
  - Tips
tags:
  - adminsys
  - Sécurité
excerpt_separator: <!--more-->
---
<div id="attachment_2373" style="width: 310px" class="wp-caption alignnone">
  <a href="http://blog.ledez.net/wp-content/uploads/2015/04/Flat-coated_Retriever_Molly.jpg"><img class="size-medium wp-image-2373" src="http://blog.ledez.net/wp-content/uploads/2015/04/Flat-coated_Retriever_Molly-300x225.jpg" alt="Pour ne pas finir à poil sur Internet" width="300" height="225" srcset="http://blog.ledez.net/wp-content/uploads/2015/04/Flat-coated_Retriever_Molly-300x225.jpg 300w, http://blog.ledez.net/wp-content/uploads/2015/04/Flat-coated_Retriever_Molly.jpg 800w" sizes="(max-width: 300px) 100vw, 300px" /></a>
  
  <p class="wp-caption-text">
    Pour ne pas finir à poil sur Internet
  </p>
</div>

Ce matin, mon copain Antony me demande &laquo;&nbsp;C&rsquo;est quoi ta check-list pour vérifier la sécurité sur un serveur ?&nbsp;&raquo;.

Je ne m&rsquo;étais jamais posé la question. Du coup, je vais la faire ici :p

<!--more-->

  * Faire un tour dans la configuration SSH 
      * Changer le port (Port) ?
      * Restreindre les utilisateurs autorisés (AllowUsers) ?
      * Utiliser une authentification par clé à la place de mots de passe
      * Fail2ban
  * Lister les ports en écoute \`lsof -i -sTCP:LISTEN\` 
      * Mettre un Firewall
      * Ou restreindre les IP en écoute (* c&rsquo;est toutes les interfaces, 127.0.0.1 c&rsquo;est que en local)
  * Lister les deamons sur la machine (ps faux) 
      * Enlever ce qui ne sert pas (bien être sur)
      * Vérifier les configurations type login/pass par défaut
  * Gérer les mises à jour avec un truc du &laquo;&nbsp;apticron&nbsp;&raquo; ou un plugin nagios &laquo;&nbsp;check_apt&nbsp;&raquo;
  * Installer un outil du type &laquo;&nbsp;logcheck&nbsp;&raquo;
  * Enlever les entêtes serveur (type HTTP avec version, etc.)

Et toi ?

Crédit image : [wikipédia][1] & [wikipédia aussi][2]

 [1]: http://en.wikipedia.org/wiki/Security#/media/File:Security_spikes_1.jpg
 [2]: http://commons.wikimedia.org/wiki/File:Flat-coated_Retriever_Molly.jpg
