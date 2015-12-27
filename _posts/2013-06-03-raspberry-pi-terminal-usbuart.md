---
id: 743
title: Raspberry π / Terminal USB/UART
author: Nicolas Ledez
layout: post
guid: http://blog.ledez.net/?p=743
permalink: /informatique/raspberry-pi-terminal-usbuart/
hide_post_title:
  - default
unlink_post_title:
  - default
hide_post_meta:
  - default
hide_post_date:
  - default
hide_post_image:
  - default
unlink_post_image:
  - default
builder_switch_frontend:
  - 0
categories:
  - Informatique
  - Tips
tags:
  - Raspberryπ
  - serial
  - usb
excerpt_separator: <!--more-->
---
[<img class="alignnone  wp-image-744" alt="RaspberryPi" src="/images/2013/06/RaspberryPi-1024x682.jpeg" width="372" height="247" />][1]

Si toi aussi tu as un Raspberry π. Mais que tu n&rsquo;as pas de Minitel (pour savoir comment, va voir la session de [@lhuet35][2] au [Breizhcamp][3]).

Sinon l&rsquo;autre solution est de lire le reste de l&rsquo;article.

<!--more-->

Il ne te reste qu&rsquo;à acheter un adaptateur à base de CP2102 :

[<img class="alignnone  wp-image-748" alt="CP2102" src="/images/2013/06/CP2102.jpg" width="480" height="480" srcset="http://blog.ledez.net/wp-content/uploads/2013/06/CP2102-150x150.jpg 150w, http://blog.ledez.net/wp-content/uploads/2013/06/CP2102-300x300.jpg 300w, http://blog.ledez.net/wp-content/uploads/2013/06/CP2102.jpg 800w" sizes="(max-width: 480px) 100vw, 480px" />][4]

&nbsp;

J&rsquo;ai acheté le mien une fortune (au moins $2.67 frais de port inclus) sur [Ebay][5].

Ensuite, tu branche :

  * Le fil orange sur TX
  * Le fil rouge sur RX
  * <span style="line-height: 13px;">Le fil marron sur GND</span>

Tu prend ton Raspberry π (éteint c&rsquo;est mieux). Et tu branche dans l&rsquo;ordre :

[<img class="size-full wp-image-745 alignnone" title="Les ports GPIO" alt="GPIOs" src="/images/2013/06/GPIOs.png" width="254" height="581" />][6]

&nbsp;

Le marron sur le PIN 6 (Ground)

L&rsquo;orange sur le PIN 8 (TXD)

Le rouge sur le PIN 10 (RXD)

Ca donne ça, et ça fonctionne <img src="/images/smilies/simple-smile.png" alt=":)" class="wp-smiley" style="height: 1em; max-height: 1em;" />

[<img class="alignnone size-large wp-image-750" alt="RaspberryPi-USBSerial" src="/images/2013/06/RaspberryPi-USBSerial-1024x732.jpg" width="620" height="443" srcset="http://blog.ledez.net/wp-content/uploads/2013/06/RaspberryPi-USBSerial-300x214.jpg 300w, http://blog.ledez.net/wp-content/uploads/2013/06/RaspberryPi-USBSerial-1024x732.jpg 1024w, http://blog.ledez.net/wp-content/uploads/2013/06/RaspberryPi-USBSerial.jpg 1280w" sizes="(max-width: 620px) 100vw, 620px" />][7]

&nbsp;

Et pour me connecter à partir de mon Mac, ça donne :

{% highlight bash %}
screen /dev/tty.SLAB_USBtoUART 115200
{% endhighlight %}

 [1]: http://blog.ledez.net/wp-content/uploads/2013/06/RaspberryPi.jpeg
 [2]: https://twitter.com/lhuet35 "Laurent Huet aka Minitel master"
 [3]: http://www.breizhcamp.org/programme/ "Va voir la session "Minitel on the cloud""
 [4]: 2013/06/CP2102.jpg
 [5]: http://www.ebay.com/sch/i.html?_nkw=CP2102 "Ebay"
 [6]: 2013/06/GPIOs.png
 [7]: http://blog.ledez.net/wp-content/uploads/2013/06/RaspberryPi-USBSerial.jpg
