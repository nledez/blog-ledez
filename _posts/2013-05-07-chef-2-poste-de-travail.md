---
id: 617
title: 'Utiliser chef #2 &#8211; Installation du poste de travail'
author: Nicolas Ledez
layout: post
guid: http://blog.ledez.net/?p=617
permalink: /informatique/chef-2-poste-de-travail/
categories:
  - DevOps
  - Informatique
tags:
  - bundler
  - chef
  - devops
  - ruby
excerpt_separator: <!--more-->
---
La suite du [précédent article &laquo;&nbsp;Utiliser chef #1 – Création d’un compte chez Opscode&nbsp;&raquo;][1]

<img class="alignnone size-full wp-image-620" alt="Chef2-BandeauChefVim" src="/images/2013/04/Chef2-BandeauChefVim.png" width="849" height="66" srcset="http://blog.ledez.net/wp-content/uploads/2013/04/Chef2-BandeauChefVim-300x23.png 300w, http://blog.ledez.net/wp-content/uploads/2013/04/Chef2-BandeauChefVim.png 849w" sizes="(max-width: 849px) 100vw, 849px" />

Parce que pour un bon Chef, le plus important c&rsquo;est un bon poste de travail !

<em id="__mceDel"><!--more-->

<em id="__mceDel">A commencer par :</em><br /> <a href="2013/04/Chef2-Hote.jpeg"><img class="size-full wp-image-624 alignnone" alt="Une Hote" src="http://blog.ledez.net/wp-content/uploads/2013/04/Chef2-Hote.jpeg" width="300" height="152" /></a>

<em id="__mceDel"><em id="__mceDel">Bon, plus sérieusement, vous verrez souvent ce schéma dans les présentations Chef :</em></em>

<em id="__mceDel"><a href="2013/04/overview_chef_draft.png"><img alt="Architecture Chef" src="http://blog.ledez.net/wp-content/uploads/2013/04/overview_chef_draft.png" width="600" height="560" /></a></em>

<em id="__mceDel">On peut y voir plusieurs parties trés importantes :</em>

### L&rsquo;ensemble des éléments pour construire un serveur

Je vais appeler cet ensemble &laquo;&nbsp;la cuisine&nbsp;&raquo; dans la suite de mes articles.

#### Les recettes (recipes)

C&rsquo;est un script écrit, dans un [DSL (Domain specific language)][2] l&rsquo;exécution se fait, dans le sens de la lecture. Cela va remplacer votre script d&rsquo;installation automatique :).

#### Les attributs (attributes)

Comme vos recettes vont s&rsquo;exécuter sur des machines différentes, vous allez vouloir changer des informations. Par exemple, une adresse mail, un nom de virtualhost, une taille mémoire, etc.

#### Les livres de recettes (cookbooks)

C&rsquo;est l&rsquo;ensemble des recettes rassemblées dans un package pour gérer un composant. Pour gèrer par exemple Apache, des versions de Java, Ruby, des serveurs d&rsquo;application Rails, Tomcat, etc. Un cookbook pour Apache2 va contenir tout pour installer et configurer le serveur et ses vhosts. Et l&rsquo;on peut gérer plusieurs versions de ces cookbooks.

#### Les sacs de données (data bags, oui je sais la traduction n&rsquo;est pas trés classe !)

Pour mettre en vrac :p les informations qui vont êtres utilisés par les recettes. Comme par exemple, la définition d&rsquo;un utilisateur avec sa clée SSH, une application, etc.

#### Les roles

Ils vont permettre d&rsquo;assembler plusieurs recettes pour gérer un type de serveur.

#### Les environnements

Production, préproduction, etc. En limitant les versions de recette dans les différents environnements, nous allons pouvoir mettre en place une stratégie de validation des applications/middlewares.

#### On va faire quoi de tout ça ?

#### Les noeuds (nodes)

Le but est d&rsquo;installer nos machines qui peuvent être physiques, virtualisées ou dans le Cloud (c&rsquo;est à la mode parait-il <img src="/images/smilies/simple-smile.png" alt=":)" class="wp-smiley" style="height: 1em; max-height: 1em;" /> ). Ce sont donc des noeuds. Pour exécuter les recettes sur les machines, vous avez le choix entre :

  * chef-solo qui va être lancé sur une machine isolée
  * Et chef-client qui va utiliser le reste de l&rsquo;infrastructure que nous allons voir

Dans les deux cas, il y a la librairie &lsquo;ohai&rsquo; qui liste plein d&rsquo;informations sur la machine. Et la run-list définie ce qui va être réalisé sur notre serveur.

#### Le serveur chef

Nous allons installer toute notre cuisine sur un serveur pour le distribuer à nos noeuds. En plus de tout ça, il y a un moteur de recherche qui permet de trouver les noeuds en fonction de différents critères. Mais aussi un manager qui est la GUI sur laquelle vous vous êtes connecté dans [l&rsquo;article 1][1].

#### Le poste de travail (workstation)

Et pour gérer tout ça en ligne de commande, il y a l&rsquo;outil &laquo;&nbsp;knife&nbsp;&raquo;.

# L&rsquo;installation sur le poste

Comme vous avez installé Ruby c&rsquo;est trés simple :

{% highlight bash %}
% gem install chef --no-ri --no-rdoc
Successfully installed chef-11.4.4
1 gem installed

% rbenv rehash # Si vous utilisez rbenv
{% endhighlight %}

Allez donc un tour à l&rsquo;adresse de la [console d&rsquo;administration Opscode][3].

Et générez la configuration de knife :  
[<img class="alignnone size-full wp-image-635" alt="Génération de la configuration de knife" src="/images/2013/04/Chef2-generate-knife-config.png" width="605" height="283" srcset="http://blog.ledez.net/wp-content/uploads/2013/04/Chef2-generate-knife-config-300x140.png 300w, http://blog.ledez.net/wp-content/uploads/2013/04/Chef2-generate-knife-config.png 605w" sizes="(max-width: 605px) 100vw, 605px" />][4]

Préparez la clé de validation :  
[<img class="alignnone size-full wp-image-639" alt="Génération de la clé de validation" src="/images/2013/04/Chef2-generate-validator-key.png" width="605" height="283" srcset="http://blog.ledez.net/wp-content/uploads/2013/04/Chef2-generate-validator-key-300x140.png 300w, http://blog.ledez.net/wp-content/uploads/2013/04/Chef2-generate-validator-key.png 605w" sizes="(max-width: 605px) 100vw, 605px" />][5]

Et copiez les fichiers téléchargé dans le répertoire &laquo;&nbsp;.chef&nbsp;&raquo;. Il resemble à ça pour le fichier &laquo;&nbsp;knife.rb&nbsp;&raquo; :

{% highlight ruby %}
current_dir = File.dirname(__FILE__)
log_level :info
log_location STDOUT
node_name "nledez-demo"
client_key "#{current_dir}/nledez-demo.pem"
validation_client_name "nledez-demo-validator"
validation_key "#{current_dir}/nledez-demo-validator.pem"
chef_server_url "https://api.opscode.com/organizations/nledez-demo"
cache_type 'BasicFile'
cache_options( :path =&gt; "#{ENV['HOME']}/.chef/checksums" )
cookbook_path ["#{current_dir}/../cookbooks"]
{% endhighlight %}

Fichier &laquo;&nbsp;nledez-demo.pem&nbsp;&raquo; :

{% highlight text %}
-----BEGIN RSA PRIVATE KEY-----
dnutNWZEhXApWvImbZdMw3bX0wVW28i7EADKz2cApPcWNYNyK2fN1fx6Y9m7bvEwp
boJYSf1JlkSWa68k0HXT6Bu8yJDWwHMfNwpJNQoTJsSoieZRNNxjlNL6m9QVjUpDX
jS1vCWemC3CbY2eUdffL8v4RMCJV9RoejcIISej7maprol240Eakz22ivqrVt6oQ4
KEOqEBPKFgke1ok6Dt0vwkAZfFjx7Wkraq9Tl9BbigQgsHPqbjFFvvItyxiXNMmMt
[...]
-----END RSA PRIVATE KEY-----
{% endhighlight %}

Placez vos clés dans le même répertoire :

{% highlight bash %}
% ls .chef
knife.rb nledez-demo-validator.pem nledez-demo.pem
{% endhighlight %}

Et pour tester que la configuration marche bien :

{% highlight bash %}
% for i in node client cookbook environment role ; do echo "===== $i:" ; knife $i list ; done
===== node:

===== client:
nledez-demo-validator
===== cookbook:

===== environment:
_default
===== role:
{% endhighlight %}

Vous constatez que c&rsquo;est la même chose que dans l&rsquo;IHM Web <img src="/images/smilies/simple-smile.png" alt=":)" class="wp-smiley" style="height: 1em; max-height: 1em;" />

Pour une raison que je n&rsquo;explique pas, la clé que j&rsquo;ai générée dans l&rsquo;article précédent ne marchait pas&#8230;  
Je l&rsquo;ai regénérée à [l&rsquo;adresse de la gestion de compte][6].

[<img class="alignnone size-full wp-image-643" alt="Régénérer sa clé utilisateur" src="/images/2013/04/Chef2-reset-user-key.png" width="520" height="248" srcset="http://blog.ledez.net/wp-content/uploads/2013/04/Chef2-reset-user-key-300x143.png 300w, http://blog.ledez.net/wp-content/uploads/2013/04/Chef2-reset-user-key.png 520w" sizes="(max-width: 520px) 100vw, 520px" />][7]

Voila voila, si tout ça marche pour vous c&rsquo;est bon pour les articles à suivre. Sinon il va falloir trouver pourquoi <img src="/images/smilies/simple-smile.png" alt=":)" class="wp-smiley" style="height: 1em; max-height: 1em;" />

Vous pourrez retrouver les fichiers utilisés [sur mon compte Github][8].  
Et la version de l&rsquo;article courant dans [le tag article01][9].

Crédit photos :

  * [<span style="line-height: 13px;">Opscode</span>][10]
  * [Vim][11]

[La suite chef !][12]

 [1]: http://blog.ledez.net/informatique/utiliser-chef-1-opscode/ "Utiliser chef #1 – Création d’un compte chez Opscode"
 [2]: http://fr.wikipedia.org/wiki/Domain-specific_programming_language "Page Wikipedia des DSL"
 [3]: https://manage.opscode.com/organizations
 [4]: 2013/04/Chef2-generate-knife-config.png
 [5]: 2013/04/Chef2-generate-validator-key.png
 [6]: https://www.opscode.com/account/password
 [7]: 2013/04/Chef2-reset-user-key.png
 [8]: https://github.com/nledez/chef-demo-repo
 [9]: https://github.com/nledez/chef-demo-repo/tree/article01
 [10]: http://www.opscode.com/
 [11]: http://www.vim.fr/element.asp?ID=1396
 [12]: http://blog.ledez.net/divers/chef-3-tdd-1/ "Utiliser Chef #3 – TDD ! 1/2"
