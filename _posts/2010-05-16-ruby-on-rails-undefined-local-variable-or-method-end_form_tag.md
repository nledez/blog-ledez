---
id: 146
title: 'Ruby On Rails : undefined local variable or method `end_form_tag&rsquo;'
author: Nicolas Ledez
layout: post
guid: http://blog.ledez.net/?p=146
permalink: /informatique/ruby-on-rails-undefined-local-variable-or-method-end_form_tag/
xLanguage_Available:
  - ,fr,en,
categories:
  - Informatique
  - Rails
  - Ruby
tags:
  - rails
  - tips
---
I try this in Ruby On Rails (ROR) :

<div class="codecolorer-container rails default" style="overflow:auto;white-space:nowrap;">
  <div class="rails codecolorer">
    <span class="sy0"><%</span>= <span class="kw5">form_remote_tag</span> <span class="sy0">%></span><br /> <span class="sy0"><%</span>= end_form_tag <span class="sy0">%></span>
  </div>
</div>

But I have this error :

<div class="codecolorer-container text default" style="overflow:auto;white-space:nowrap;">
  <div class="text codecolorer">
    undefined local variable or method `end_form_tag' for #
  </div>
</div>

I search a lot of time this Week-End (without) Internet.

I found a solution here :  
<http://ajzone.wordpress.com/2008/03/11/ruby-on-rails-202/>

First replace :

<div class="codecolorer-container rails default" style="overflow:auto;white-space:nowrap;">
  <div class="rails codecolorer">
    <span class="sy0"><%</span>= end_form_tag <span class="sy0">%></span>
  </div>
</div>

With :

<div class="codecolorer-container rails default" style="overflow:auto;white-space:nowrap;">
  <div class="rails codecolorer">
    <span class="sy0"><%</span>= <span class="kw1">end</span> <span class="sy0">%></span>
  </div>
</div>

Because &laquo;&nbsp;end\_form\_tag&nbsp;&raquo; is deprecated. But after this correction I have this error :

<div class="codecolorer-container text default" style="overflow:auto;white-space:nowrap;">
  <div class="text codecolorer">
    compile error<br /> /home/nico/testror/app/views/test/index.html.erb:1: syntax error, unexpected ')'
  </div>
</div>

Add a do the the form tag:

<div class="codecolorer-container rails default" style="overflow:auto;white-space:nowrap;">
  <div class="rails codecolorer">
    <span class="sy0"><%</span>= <span class="kw5">form_remote_tag</span> <span class="kw1">do</span> <span class="sy0">%></span>
  </div>
</div>

And now there are:

<div class="codecolorer-container rails default" style="overflow:auto;white-space:nowrap;">
  <div class="rails codecolorer">
    compile error<br /> <span class="sy0">/</span>home<span class="sy0">/</span>nico<span class="sy0">/</span>testror<span class="sy0">/</span>app<span class="sy0">/</span>views<span class="sy0">/</span>test<span class="sy0">/</span>index.<span class="me1">html</span>.<span class="me1">erb</span>:<span class="nu0">2</span>: syntax error, unexpected kEND
  </div>
</div>

Transform this:  
<code lang="rails"><br />
<%= form_remote_tag do %><br />
<%= end %><br />
<code></p>
<p>To:<br />
<code lang="rails"><br />
<% form_remote_tag do %><br />
<% end %><br />
<code></p>
<p>The error come from the "=" char.</p>