---
id: 356
title: Pow pour les nuls
author: Nicolas Ledez
layout: post
guid: http://blog.ledez.net/?p=356
permalink: /informatique/tips/pow-pour-les-nuls/
categories:
  - Ruby
  - Tips
tags:
  - mac
  - osx
  - pow
  - rails
  - ruby
  - zsh
excerpt_separator: <!--more-->
---
Toutes les étapes pour avoir une machine avec un Pow et Zsh qui torchent ! :

  * Installer Pow
  * Installer OH MY ZSHELL!
  * Modification de la configuration par défaut
  * Et son utilisation
  * Bonus

<!--more-->

### Installer Pow

[Extrait du site de Pow][1]  
C&rsquo;est le plus dur :p

{% highlight bash %}
$ curl get.pow.cx | sh
{% endhighlight %}

Maintenant une connexion sur un site http://<app>.dev/ doit fonctionner.  
Pour une nouvelle application, le mode opératoire est simple :

{% highlight bash %}
$ cd ~/.pow
$ ln -s /path/to/myapp
{% endhighlight %}

Pff trop la flemme&#8230;

Pour gagner du temps, on va installer ZSH, avec le plugin &laquo;&nbsp;quivabien&nbsp;&raquo; :

### Installer OH MY ZSHELL!

[Extrait du site oh-my-zsh][2]

{% highlight bash %}
$ curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh
{% endhighlight %}

Si jamais votre Shell par défaut est écrasé (en général bash). Vous pouvez revenir en arrière :

{% highlight ruby %}
chsh -s /bin/bash
{% endhighlight %}

### Modification de la configuration par défaut

Modifier la ligne dans le fichier ~/.zshrc :

{% highlight bash %}
plugins=(git brew bundler gem heroku osx pow rails3 redis-cli textmate)
{% endhighlight %}

C&rsquo;est surtout le plugin pow qu&rsquo;il faut mettre, les autres sont ceux que j&rsquo;utilise. Choisissez vos armes.

### Et son utilisation

Si l&rsquo;on regarde le contenu du fichier ~/.oh-my-zsh/plugins/pow/pow.plugin.zsh, on apprend qu&rsquo;il y a 3 commandes à disposition :

  * powit qui permet de &laquo;&nbsp;d&rsquo;installer&nbsp;&raquo; un nouveau site
  * kapow qui permet de redémarrer une application. Avec en argument le nom du vhost ou sans argument dans le répertoire de l&rsquo;application
  * kaput (puts) qui permet d&rsquo;afficher les logs de l&rsquo;application

### Bonus

Je ne me souviens jamais des URL à taper. Et j&rsquo;ai trop la (flemme|pas envie de faire peur à mon client), j&rsquo;aimerais donc avoir l&rsquo;adresse http://index.dev/ qui me donne la liste de toutes mes applications.

On peut utiliser dans ce cas l&rsquo;application [Pow-index][3].

Si vous n&rsquo;avez pas ça :

{% highlight bash %}
% gem search --remote pow-index                                                                                        !6441

*** REMOTE GEMS ***

pow-index (0.0.4)
{% endhighlight %}

Regardez plus bas (la version git).

Sans [RVM][4] :

{% highlight bash %}
$ gem install pow-index
$ pow-index index
{% endhighlight %}

Avec [RVM][4] :

{% highlight bash %}
$ rvm use default@pow-index --create
$ gem install pow-index
$ pow-index index
$ gem which pow-index
$ cd $(gem which pow-index | sed 's#lib/pow-index.rb$##')
$ echo 'rvm use default@pow-index' &gt; .rvmrc
{% endhighlight %}

J&rsquo;ai fais quelques modifications suplémentaires dans un fork sur Github, [@marutanm][5] répond rapidement aux pull-request il devrait donc y avoir une version 0.0.5. En attendant :

{% highlight bash %}
$ git clone https://nledez@github.com/nledez/Pow-index.git
$ cd Pow-index
$ ln -s $(pwd) ~/.pow/index
{% endhighlight %}

Vous pouvez aussi remplacer index par default. Dans ce cas, n&rsquo;importe quelle URL qui se termine en .dev seras redirigé vers celui-là.

Et voilà plus qu&rsquo;à apprendre coder comme des malades <img src="smilies/simple-smile.png" alt=":)" class="wp-smiley" style="height: 1em; max-height: 1em;" />

 [1]: http://pow.cx/ "Site de Pow"
 [2]: https://github.com/robbyrussell/oh-my-zsh "Site de oh-my-zsh"
 [3]: https://github.com/marutanm/Pow-index "Site de Pow-index"
 [4]: https://rvm.beginrescueend.com/ "Site de RVM"
 [5]: https://twitter.com/#!/marutanm "@marutanm"
