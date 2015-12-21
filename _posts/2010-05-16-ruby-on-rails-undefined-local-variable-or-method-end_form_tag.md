---
id: 146
title: 'Ruby On Rails : undefined local variable or method `end_form_tag&rsquo;'
author: Nicolas Ledez
layout: post
guid: http://blog.ledez.net/?p=146
permalink: /informatique/ruby-on-rails-undefined-local-variable-or-method-end_form_tag/
categories:
  - Informatique
  - Rails
  - Ruby
tags:
  - rails
  - tips
---
I try this in Ruby On Rails (ROR) :

{% highlight erb %}
<%= form_remote_tag %>
<%= end_form_tag %>
{% endhighlight %}

But I have this error :

{% highlight text %}
undefined local variable or method `end_form_tag' for #
{% endhighlight %}

I search a lot of time this Week-End (without) Internet.

I found a solution here :  
<http://ajzone.wordpress.com/2008/03/11/ruby-on-rails-202/>

First replace :

{% highlight erb %}
<%= end_form_tag %>
{% endhighlight %}

With :

{% highlight erb %}
<%= end %>
{% endhighlight %}

Because &laquo;&nbsp;end\_form\_tag&nbsp;&raquo; is deprecated. But after this correction I have this error :

{% highlight text %}
compile error
/home/nico/testror/app/views/test/index.html.erb:1: syntax error, unexpected ')'
{% endhighlight %}

Add a do the the form tag:

{% highlight erb %}
<%= form_remote_tag do %>
{% endhighlight %}

And now there are:

{% highlight text %}
compile error
/home/nico/testror/app/views/test/index.html.erb:2: syntax error, unexpected kEND
{% endhighlight %}

Transform this:  
{% highlight erb %}
<%= form_remote_tag do %>
<%= end %>
{% endhighlight %}
To:

{% highlight text %}
<% form_remote_tag do %>
<% end %>
{% endhighlight %}

<p>The error come from the "=" char.</p>
