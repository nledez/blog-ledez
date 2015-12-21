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

<div class="codecolorer-container bash default" style="overflow:auto;white-space:nowrap;">
  <div class="bash codecolorer">
    <span class="kw3">echo</span> <span class="st_h">'rvm --create use default@rails > /dev/null'</span> <span class="sy0">></span> .rvmrc<br /> <span class="kw3">cd</span> ; <span class="kw3">cd</span> -<br /> gem <span class="kw2">install</span> rails rspec-rails cucumber-rails capybara web-app-theme
  </div>
</div>