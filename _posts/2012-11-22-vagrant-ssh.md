---
id: 508
title: 'Vagrant &#038; SSH'
author: Nicolas Ledez
layout: post
guid: http://blog.ledez.net/?p=508
permalink: /informatique/vagrant-ssh/
categories:
  - Informatique
  - Tips
tags:
  - ssh
  - vagrant
---
Suite au Tweet : <a title="de @ndeloof" href="https://twitter.com/ndeloof/statuses/271386955785318400" target="_blank">https://twitter.com/ndeloof/statuses/271386955785318400</a>

Et que ma solution ne tient pas en 140 caractères :

{% highlight bash %}
ssh -p 2222 -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -i ~/.vagrant.d/insecure_private_key vagrant@localhost
{% endhighlight %}

Sinon dans votre ~/.ssh/config :

{% highlight bash %}
Host vagrant-box
  Hostname localhost
  User vagrant
  Port 2222
  StrictHostKeyChecking no
  UserKnownHostsFile /dev/null
  IdentityFile ~/.vagrant.d/insecure_private_key
{% endhighlight %}

Maintenant, vos :

{% highlight bash %}
ssh vagrant-box
knife cook
{% endhighlight %}

Vont marcher direct !
