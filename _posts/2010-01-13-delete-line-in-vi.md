---
id: 134
title: Delete line in vi
author: Nicolas Ledez
layout: post
guid: http://blog.ledez.net/?p=134
permalink: /divers/delete-line-in-vi/
categories:
  - Divers
  - Tips
tags:
  - tips
  - vim
---
To delete line in vi(m) if line respect a pattern :

<div class="codecolorer-container text default" style="overflow:auto;white-space:nowrap;">
  <div class="text codecolorer">
    :g/^#/ d
  </div>
</div>

Is delete comment lines

<div class="codecolorer-container text default" style="overflow:auto;white-space:nowrap;">
  <div class="text codecolorer">
    :g/^$/ d
  </div>
</div>

Is delete empty lines