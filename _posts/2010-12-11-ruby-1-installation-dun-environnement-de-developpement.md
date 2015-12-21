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

{% highlight bash %}
bash < <( curl http://rvm.beginrescueend.com/releases/rvm-install-head )
vi ~/.bashrc
# == Mettre à la fin du fichier
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"  # This loads RVM into a shell session.
[[ -r $rvm_path/scripts/completion ]] && . $rvm_path/scripts/completion
# ==== Fin
. ~/.bashrc
{% endhighlight %}

Machine multifonction développement, production (plusieurs users) :

{% highlight bash %}
bash < <( curl -L http://bit.ly/rvm-install-system-wide )
vi ~/.bashrc
# == Mettre à la fin du fichier
[[ -s "/usr/local/lib/rvm" ]] && . "/usr/local/lib/rvm"  # This loads RVM into a shell session.
[[ -r $rvm_path/scripts/completion ]] && . $rvm_path/scripts/completion
# ==== Fin
sudo adduser $USER rvm
. ~/.bashrc
{% endhighlight %}

Maintenant, installer Ruby et les gems initiaux :

{% highlight bash %}
rvm install ree
rvm gemset create dev
rvm gemset use dev
gem install autotest rcov redgreen ZenTest rspec
gem install test_notifier --version '< 0.2.0'
{% endhighlight %}

A partir de là, vous avez une machine qui permet de développer en Ruby.
