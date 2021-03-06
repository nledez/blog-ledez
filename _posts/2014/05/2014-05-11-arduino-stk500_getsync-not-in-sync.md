---
id: 1004
title: 'Arduino &laquo;&nbsp;stk500_getsync(): not in sync&nbsp;&raquo;'
author: Nicolas Ledez
layout: post
guid: http://blog.ledez.net/?p=1004
permalink: /diy/arduino-stk500_getsync-not-in-sync/
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
  - DIY
excerpt_separator: <!--more-->
---
[<img class="alignnone size-full wp-image-1019" src="{{ site.url }}/images/2014/05/BannerArduinoStk500_getsync.jpg" alt="BannerArduinoStk500_getsync" width="751" height="140" />][1]

Comme tu as pu voir [ici][2], et [ici][3] j&rsquo;aime bien les Ardiuno. Mais j&rsquo;ai rencontré pas mal de problèmes avec les derniers que j&rsquo;ai reçus.

J&rsquo;avais souvent l&rsquo;erreur &laquo;&nbsp;stk500_getsync(): not in sync&nbsp;&raquo;.

Après quelques mois à chercher voici ma solution :<!--more-->

### L&rsquo;énoncé

Je suis souvent tombé sur cette erreur :

{% highlight text %}
avrdude: Version 5.11, compiled on Sep 2 2011 at 18:52:52
Copyright (c) 2000-2005 Brian Dean, http://www.bdmicro.com/
Copyright (c) 2007-2009 Joerg Wunsch

System wide configuration file is "/Applications/Dev/Arduino.app/Contents/Resources/Java/hardware/tools/avr/etc/avrdude.conf"
User configuration file is "/Users/nico/.avrduderc"
User configuration file does not exist or is not a regular file, skipping

Using Port : /dev/tty.usbserial-A9ELLV3R
Using Programmer : arduino
Overriding Baud Rate : 57600
avrdude: Send: 0 [30] [20]
avrdude: Send: 0 [30] [20]
avrdude: Send: 0 [30] [20]
avrdude: Recv: . [00]
avrdude: stk500_getsync(): not in sync: resp=0x00

avrdude done. Thank you.
{% endhighlight %}

J&rsquo;ai cherché pendant des heures sur le Net comment résoudre ce &laquo;&nbsp;stk500_getsync(): not in sync: resp=0x00&nbsp;&raquo;.

J&rsquo;ai trouvé des solutions comme mettre un condensateur de 10µF entre la patte DTR et le reset de l&rsquo;Arduino.

Au final, la solution (sur mon Mac) était de réinstaller complètement les drivers. Pour info, je m&rsquo;en suis rendu compte en essayant sur un Linux (ça a marché directement).

### Voici donc comment faire

#### Avec le pl2303hx

{% highlight bash %}
cd /System/Library/Extensions
sudo mv NoZAP-PL2303-10.9.kext ~/Desktop/
sudo mv ProlificUsbSerial.kext ~/Desktop/
cd /var/db/receipts
sudo mv com.prolific.prolificUsbserialCableDriverV151.ProlificUsbSerial.pkg.bom com.prolific.prolificUsbserialCableDriverV151.ProlificUsbSerial.pkg.plist ~/Desktop/
{% endhighlight %}

Un petit reboot pour être sûr.

Ensuite, télécharger Mac OS X Universal Binary Driver sur la page :  
<http://prolificusa.com/portfolio/pl2303hx-rev-d-usb-to-serial-bridge-controller/>

Le fichier était le &laquo;&nbsp;md\_PL2303\_MacOSX-10\_6up\_v1\_5\_1.zip&nbsp;&raquo;.

Puis l&rsquo;installer.

#### Et avec le FTDI

{% highlight bash %}
cd /System/Library/Extensions
sudo mv FTDIUSBSerialDriver.kext ~/Desktop/
{% endhighlight %}

Le petit reboot de précaution.

Télécharger le driver VCP sur la page :  
<http://www.ftdichip.com/Drivers/VCP.htm>

Le fichier était le &laquo;&nbsp;FTDIUSBSerialDriver\_v2\_2_18.dmg&nbsp;&raquo;.

#### Tout en même temps

  * Faire toutes les suppressions
  * Le reboot
  * Les installations de drivers (il y en a un qui demande de rebooter à la fin et pas l&rsquo;autre. Mais je ne me souviens plus lesquels)

Enjoy !

 [1]: 2014/05/BannerArduinoStk500_getsync.jpg
 [2]: {{ site.url }}/diy/commande-electronique-semaine-1/ "Commande électronique de la semaine #1 – DIY"
 [3]: {{ site.url }}/diy/commande-electronique-semaine-2-diy/ "Commande électronique de la semaine #2 – DIY"
