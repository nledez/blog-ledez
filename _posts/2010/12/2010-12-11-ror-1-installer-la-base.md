---
id: 210
title: 'ROR #1 &#8211; Installer la base'
author: Nicolas Ledez
layout: post
guid: http://blog.ledez.net/?p=210
permalink: /divers/ror-1-installer-la-base/
categories:
  - Divers
  - Rails
tags:
  - howto
  - rails
---
Installer les éléments de base pour développer en Rails :

{% highlight bash %}
echo 'rvm --create use default@rails > /dev/null' > .rvmrc
cd ; cd -
gem install rails rspec-rails cucumber-rails capybara web-app-theme
{% endhighlight %}
