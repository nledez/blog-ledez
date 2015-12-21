---
id: 791
title: Ruby ta première librairie
author: Nicolas Ledez
layout: post
guid: http://blog.ledez.net/?p=791
permalink: /informatique/ruby/ruby-ta-premiere-librairie/
categories:
  - Ruby
tags:
  - ruby
  - TDD
---
[<img class="alignnone  wp-image-792" alt="Ruby" src="http://blog.ledez.net/wp-content/uploads/2013/06/Ruby.png" width="181" height="181" srcset="http://blog.ledez.net/wp-content/uploads/2013/06/Ruby-150x150.png 150w, http://blog.ledez.net/wp-content/uploads/2013/06/Ruby-300x300.png 300w, http://blog.ledez.net/wp-content/uploads/2013/06/Ruby.png 504w" sizes="(max-width: 181px) 100vw, 181px" />][1] Je sais bien que ça te démange toi aussi de [pisser du code][2].

<troll>Et quoi de mieux que de faire du Ruby ?</troll>

Nous allons tout mettre en place pour que tu puisses faire du TDD rapidement.

<!--more-->

## Les prérequis :

  * Ton cerveau (pour bien comprendre la suite)
  * Growl pour les notifications (Pour [OsX][3], ou [Windows][4])
  * Une version de Ruby (avec [rbenv][5] pour OS X, ou avec un [installeur pour Windows][6]) je suis encore avec la version 1.9.3 si tu te poses la question
  * Git (Pour [Windows][7], Mac Os X via [Homebrew][8], et pour Linux tu sais faire)

## Prêt ?

Pour commencer, création d&rsquo;une librairie vide grâce à bundle :

<div class="codecolorer-container text default" style="overflow:auto;white-space:nowrap;">
  <div class="text codecolorer">
    gem install bundler # Si jamais il n'est pas installé<br /> bundle gem demo_howto -t<br /> cd demo_howto
  </div>
</div>

\`bundle gem demo_howto -t\` permet de créer une coquille vide pour ta librairie.

Ensuite, tu édites le fichier gemspec. Dans ton cas, c&rsquo;est &laquo;&nbsp;demo_howto.gemspec&nbsp;&raquo;.

Il faut y mettre à jours les parties &laquo;&nbsp;description&nbsp;&raquo; et &laquo;&nbsp;summary&nbsp;&raquo;. Mettre un site dans la partie &laquo;&nbsp;homepage&nbsp;&raquo; est une bonne idée aussi.

Et moi j&rsquo;ajoute les librairies :

<div class="codecolorer-container ruby default" style="overflow:auto;white-space:nowrap;">
  <div class="ruby codecolorer">
    &nbsp; spec.<span class="me1">add_development_dependency</span> <span class="st0">"wdm"</span> <span class="kw1">if</span> RUBY_PLATFORM =~ <span class="sy0">/</span>mingw<span class="sy0">/</span><br /> &nbsp; spec.<span class="me1">add_development_dependency</span> <span class="st0">"ruby_gntp"</span> <span class="kw1">if</span> RUBY_PLATFORM =~ <span class="sy0">/</span>mingw<span class="sy0">/</span><br /> &nbsp; spec.<span class="me1">add_development_dependency</span> <span class="st0">"rb-fsevent"</span> <span class="kw1">if</span> RUBY_PLATFORM =~ <span class="sy0">/</span>darwin<span class="sy0">/</span><br /> &nbsp; spec.<span class="me1">add_development_dependency</span> <span class="st0">"growl"</span> <span class="kw1">if</span> RUBY_PLATFORM =~ <span class="sy0">/</span>darwin<span class="sy0">/</span><br /> &nbsp; spec.<span class="me1">add_development_dependency</span> <span class="st0">"guard"</span><br /> &nbsp; spec.<span class="me1">add_development_dependency</span> <span class="st0">"guard-rspec"</span>
  </div>
</div>

Pour installer les librairies :

<div class="codecolorer-container text default" style="overflow:auto;white-space:nowrap;">
  <div class="text codecolorer">
    bundle
  </div>
</div>

## Rouge !

Pour vérifier si tout marche :

<div class="codecolorer-container text default" style="overflow:auto;white-space:nowrap;">
  <div class="text codecolorer">
    bundle exec rspec
  </div>
</div>

Ça donne :  
[<img src="http://blog.ledez.net/wp-content/uploads/2013/06/by-default-2013-06-24-at-22.37.59.png" alt="Barre rouge" width="540" height="273" class="alignnone size-full wp-image-798" />][9]

C&rsquo;est rouge ! Et bien, comme maintenant tu fais du TDD c&rsquo;est normal tout va bien !

Avant de passer à la résolution du test, on va regarder 2/3 autres trucs.

Tu vas faire :

<div class="codecolorer-container text default" style="overflow:auto;white-space:nowrap;">
  <div class="text codecolorer">
    bundle exec guard init
  </div>
</div>

Et ouvrir le fichier &laquo;&nbsp;Guardfile&nbsp;&raquo; pour enlever les parties les moins intéressantes (Rails, toussa) :

<div class="codecolorer-container ruby default" style="overflow:auto;white-space:nowrap;">
  <div class="ruby codecolorer">
    guard <span class="re3">:rspec</span> <span class="kw1">do</span><br /> &nbsp; watch<span class="br0">&#40;</span><span class="sy0">%</span>r<span class="br0">&#123;</span>^spec<span class="sy0">/</span>.<span class="sy0">+</span>_spec\.<span class="me1">rb</span>$<span class="br0">&#125;</span><span class="br0">&#41;</span><br /> &nbsp; watch<span class="br0">&#40;</span><span class="sy0">%</span>r<span class="br0">&#123;</span>^lib<span class="sy0">/</span><span class="br0">&#40;</span>.<span class="sy0">+</span><span class="br0">&#41;</span>\.<span class="me1">rb</span>$<span class="br0">&#125;</span><span class="br0">&#41;</span> &nbsp; &nbsp; <span class="br0">&#123;</span> <span class="sy0">|</span>m<span class="sy0">|</span> <span class="st0">"spec/lib/#{m[1]}_spec.rb"</span> <span class="br0">&#125;</span><br /> &nbsp; watch<span class="br0">&#40;</span><span class="st0">'spec/spec_helper.rb'</span><span class="br0">&#41;</span> &nbsp;<span class="br0">&#123;</span> <span class="st0">"spec"</span> <span class="br0">&#125;</span><br /> <span class="kw1">end</span>
  </div>
</div>

Comme tu l&rsquo;as peut-être remarqué, il y a un léger problème de cohérence entre la partie générée par Bundler et Guard :  
Guard va chercher les specs dans le répertoire &laquo;&nbsp;spec/lib/#{m[1]}\_spec.rb&nbsp;&raquo;. Alors que Bundler l&rsquo;a mis dans &laquo;&nbsp;spec/demo\_howto_spec.rb&nbsp;&raquo;.

Donc tu fais bien comme tu veux, mais moi je déplace le fichier de spec :

<div class="codecolorer-container bash default" style="overflow:auto;white-space:nowrap;">
  <div class="bash codecolorer">
    <span class="kw2">git mv</span> spec<span class="sy0">/</span>demo_howto_spec.rb spec<span class="sy0">/</span>lib<span class="sy0">/</span>demo_howto_spec.rb
  </div>
</div>

Tu vas pouvoir essayer tout ça :

<div class="codecolorer-container text default" style="overflow:auto;white-space:nowrap;">
  <div class="text codecolorer">
    bundle exec guard
  </div>
</div>

Et si tu édites les deux fichiers dans ton éditeur de texte (moi j&rsquo;utilise vi) :

<div class="codecolorer-container text default" style="overflow:auto;white-space:nowrap;">
  <div class="text codecolorer">
    mvim -o lib/demo_howto.rb spec/lib/demo_howto_spec.rb
  </div>
</div>

Voilà de quoi démarrer <img src="https://blog.ledez.net/wp-includes/images/smilies/simple-smile.png" alt=":)" class="wp-smiley" style="height: 1em; max-height: 1em;" />

Tu peux aller voir le code sur mon [Github][10].

J’y mets aussi 2/3 autres trucs pour que tu puisses t&rsquo;amuser un peu.

## Vert !

Ha oui, tu voulais surement que ça passe vert !

Remplace donc :

<div class="codecolorer-container text default" style="overflow:auto;white-space:nowrap;">
  <div class="text codecolorer">
    &nbsp; it 'should do something useful' do<br /> &nbsp; &nbsp; false.should be_true<br /> &nbsp; end
  </div>
</div>

Par :

<div class="codecolorer-container text default" style="overflow:auto;white-space:nowrap;">
  <div class="text codecolorer">
    &nbsp; it 'should do something useful' do<br /> &nbsp; &nbsp; true.should be_true<br /> &nbsp; end
  </div>
</div>

[<img src="http://blog.ledez.net/wp-content/uploads/2013/06/by-default-2013-06-24-at-23.03.01.png" alt="La barre verte" width="221" height="93" class="alignnone size-full wp-image-801" />][11]

C&rsquo;est trop facile Ruby :p

EDIT: Ajout de Git dans les prérequis

 [1]: http://blog.ledez.net/wp-content/uploads/2013/06/Ruby.png
 [2]: http://jepisseducode.com/ "Je pisse du code !"
 [3]: http://growl.info/ "Growl pour Mac OS X"
 [4]: http://www.growlforwindows.com/gfw/ "Growl pour Windows"
 [5]: https://github.com/sstephenson/rbenv "Direction l'installation de rbenv"
 [6]: http://rubyinstaller.org/downloads/ "Un installeur Windows"
 [7]: http://msysgit.github.io/ "Git pour Windows"
 [8]: http://mxcl.github.io/homebrew/ "Homebrew"
 [9]: http://blog.ledez.net/wp-content/uploads/2013/06/by-default-2013-06-24-at-22.37.59.png
 [10]: https://github.com/nledez/demo_howto "Mon Github sur le repository de l'article"
 [11]: http://blog.ledez.net/wp-content/uploads/2013/06/by-default-2013-06-24-at-23.03.01.png