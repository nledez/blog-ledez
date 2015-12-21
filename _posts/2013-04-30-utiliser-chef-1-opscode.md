---
id: 578
title: 'Utiliser chef #1 &#8211; Création d&rsquo;un compte chez Opscode'
author: Nicolas Ledez
layout: post
guid: http://blog.ledez.net/?p=578
permalink: /informatique/utiliser-chef-1-opscode/
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
  - Informatique
tags:
  - chef
  - devops
  - opscode
---
<img class=" wp-image-587 alignleft" alt="Le logo Chef" src="http://blog.ledez.net/wp-content/uploads/2013/04/logo-chef.png" width="158" height="123" /> Premier article d&rsquo;une série pour vous aider à mettre en place Chef pour déployer vos applicatifs dans vos machines. Les premiers articles seront publiés rapidement pour vous permettre de commencer très vite. Puis les suivants seront plus espacés dans le temps afin de bien maitriser les différentes parties. Objectifs :

  * <span style="line-height: 13px;"><span style="line-height: 13px;"> M</span></span>ettre en place &laquo;&nbsp;l&rsquo;infrastructure&nbsp;&raquo;
  * Configurer le poste de développement
  * Utiliser Vagrant avec chef
  * Faire du TDD avec chef
  * Faire du BDD avec chef

Et déjà avec tout ça, vous aurez de quoi faire. <!--more--> Si le sujet vous intéresse, rendez-vous au 

[Breizhcamp][1] pour ma session &laquo;&nbsp;Introduction à DevOps&nbsp;&raquo;.

<p style="text-align: center;">
  <a title="Direction le Breizhcamp" href="http://www.breizhcamp.org/"><img class="alignnone size-large wp-image-600" alt="BreizhCamp new logo - with text XXL" src="http://blog.ledez.net/wp-content/uploads/2013/04/BreizhCamp-new-logo-with-text-XXL-1024x238.png" width="620" height="144" /></a>
</p>

Donc l&rsquo;infrastructure ! Pour démarrer en douceur, je vous propose d&rsquo;utiliser la [version hosté du serveur chef][2]. Remplissez le formulaire, à l&rsquo;issue de celui-ci il va falloir :

  * <span style="line-height: 13px;">Valider l&rsquo;enregistrement via l&#8217;email que vous allez recevoir</span>
  * Enregistrer la clé privée dans un fichier

Pour la validation, vous savez faire. Pour la clé : Copier tout le bloc

{% highlight text %}
-----BEGIN RSA PRIVATE KEY-----
{% endhighlight %}

à

{% highlight text %}
-----END RSA PRIVATE KEY-----
{% endhighlight %}

compris. Et enregistrez le contenu dans un fichier qui porte le nom de votre user et l&rsquo;extension &lsquo;.pem&rsquo;. Par la suite, ce fichier sera nommé &laquo;&nbsp;nledez-demo.pem&nbsp;&raquo; [<img class=" wp-image-609 alignleft" alt="Opscode" src="http://blog.ledez.net/wp-content/uploads/2013/04/OpscodeLogo_Tag_FINAL-1024x614.png" width="156" height="94" />][3] A partir de là, vous êtes déclaré comme utilisateur dans le système d&rsquo;Opscode. Maintenant, pour gérer vos serveurs vous aurez besoin de créer une organisation. Prenez cette direction pour [créer une organisation][4]. Je vais appeler la mienne :

  * <span style="line-height: 13px;">Ledez Corporation</span>
  * nledez-demo

Et avec le plan gratuit, pour 0$ vous avez :

  * <span style="line-height: 13px;">5 noeuds</span>
  * 2 users
  * 1 environnement

Bref, de quoi tester la solution. Je vous laisse vous découvrir tout le site d&rsquo;Opscode, j&rsquo;y reviendrais plus tard. En attendant, si vous n&rsquo;avez pas tout ça, installez (chez moi, ça marche sur un Mac, pour le reste débrouillez vous <img src="https://blog.ledez.net/wp-includes/images/smilies/simple-smile.png" alt=":)" class="wp-smiley" style="height: 1em; max-height: 1em;" /> ) :

  * <span style="line-height: 13px;">Un interpréteur Ruby &#8211; Via rbenv par exemple (<a title="Tutorial anglais pour installer un environnement Rails" href="http://blog.wyeworks.com/2012/4/13/my-osx-rails-installation-using-homebrew-and-rbenv-step-by-step/">comment installer Rails sur OSX</a> avec les steps 1 à 4, 8 à 11)</span>
  * VirtualBox (Le site de [VirtualBox][5])

Si j&rsquo;ai le temps, un des billets bonus expliquera surement la partie Linux. Si vous avez Windows, achetez un Mac, et si vous n&rsquo;avez pas de sou, installez Linux. [La suite par là.][6]

 [1]: http://www.breizhcamp.org/ "Breizhcamp"
 [2]: https://community.opscode.com/users/new "Inscription sur community opscode"
 [3]: http://blog.ledez.net/wp-content/uploads/2013/04/OpscodeLogo_Tag_FINAL.png
 [4]: https://www.opscode.com/account/plan_subscribe "Déclaration d'une organisation chez Opscode"
 [5]: https://www.virtualbox.org/ "Le site de VirtualBox"
 [6]: http://blog.ledez.net/informatique/chef-2-poste-de-travail/ "Utiliser chef #2 – Installation du poste de travail"
