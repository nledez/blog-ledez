---
id: 169
title: 'Ruby 1 &#8211; Installation d&rsquo;un environnement de developpement'
author: Nicolas Ledez
layout: post
guid: http://blog.ledez.net/?p=169
permalink: /informatique/ruby-1-installation-dun-environnement-de-developpement/
categories:
  - Informatique
  - Ruby
tags:
  - howto
  - ruby
---
Inspiré de l&rsquo;article :  
http://jeremy.wordpress.com/2010/08/13/ruby-rvm-passenger-rails-bundler-en-developpement/

Deux solutions pour installer Ruby sur votre machine :

Poste uniquement de développement &#8211; un seul utilisateur :

<div class="codecolorer-container bash default" style="overflow:auto;white-space:nowrap;">
  <div class="bash codecolorer">
    <span class="kw2">bash</span> <span class="sy0"><</span> <span class="sy0"><</span><span class="br0">&#40;</span> curl http:<span class="sy0">//</span>rvm.beginrescueend.com<span class="sy0">/</span>releases<span class="sy0">/</span>rvm-install-head <span class="br0">&#41;</span><br /> <span class="kw2">vi</span> ~<span class="sy0">/</span>.bashrc<br /> <span class="co0"># == Mettre à la fin du fichier</span><br /> <span class="br0">&#91;</span><span class="br0">&#91;</span> <span class="re5">-s</span> <span class="st0">"<span class="es2">$HOME</span>/.rvm/scripts/rvm"</span> <span class="br0">&#93;</span><span class="br0">&#93;</span> <span class="sy0">&&</span> . <span class="st0">"<span class="es2">$HOME</span>/.rvm/scripts/rvm"</span> &nbsp;<span class="co0"># This loads RVM into a shell session.</span><br /> <span class="br0">&#91;</span><span class="br0">&#91;</span> <span class="re5">-r</span> <span class="re1">$rvm_path</span><span class="sy0">/</span>scripts<span class="sy0">/</span>completion <span class="br0">&#93;</span><span class="br0">&#93;</span> <span class="sy0">&&</span> . <span class="re1">$rvm_path</span><span class="sy0">/</span>scripts<span class="sy0">/</span>completion<br /> <span class="co0"># ==== Fin</span><br /> . ~<span class="sy0">/</span>.bashrc
  </div>
</div>

Machine multifonction développement, production (plusieurs users) :

<div class="codecolorer-container bash default" style="overflow:auto;white-space:nowrap;">
  <div class="bash codecolorer">
    <span class="kw2">bash</span> <span class="sy0"><</span> <span class="sy0"><</span><span class="br0">&#40;</span> curl <span class="re5">-L</span> http:<span class="sy0">//</span>bit.ly<span class="sy0">/</span>rvm-install-system-wide <span class="br0">&#41;</span><br /> <span class="kw2">vi</span> ~<span class="sy0">/</span>.bashrc<br /> <span class="co0"># == Mettre à la fin du fichier</span><br /> <span class="br0">&#91;</span><span class="br0">&#91;</span> <span class="re5">-s</span> <span class="st0">"/usr/local/lib/rvm"</span> <span class="br0">&#93;</span><span class="br0">&#93;</span> <span class="sy0">&&</span> . <span class="st0">"/usr/local/lib/rvm"</span> &nbsp;<span class="co0"># This loads RVM into a shell session.</span><br /> <span class="br0">&#91;</span><span class="br0">&#91;</span> <span class="re5">-r</span> <span class="re1">$rvm_path</span><span class="sy0">/</span>scripts<span class="sy0">/</span>completion <span class="br0">&#93;</span><span class="br0">&#93;</span> <span class="sy0">&&</span> . <span class="re1">$rvm_path</span><span class="sy0">/</span>scripts<span class="sy0">/</span>completion<br /> <span class="co0"># ==== Fin</span><br /> <span class="kw2">sudo</span> adduser <span class="re1">$USER</span> rvm<br /> . ~<span class="sy0">/</span>.bashrc
  </div>
</div>

Maintenant, installer Ruby et les gems initiaux :

<div class="codecolorer-container bash default" style="overflow:auto;white-space:nowrap;">
  <div class="bash codecolorer">
    rvm <span class="kw2">install</span> ree<br /> rvm gemset create dev<br /> rvm gemset use dev<br /> gem <span class="kw2">install</span> autotest rcov redgreen ZenTest rspec<br /> gem <span class="kw2">install</span> test_notifier <span class="re5">--version</span> <span class="st_h">'< 0.2.0'</span>
  </div>
</div>

A partir de là, vous avez une machine qui permet de développer en Ruby.