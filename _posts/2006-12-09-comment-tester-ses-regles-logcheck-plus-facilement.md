---
id: 41
title: Comment tester ses régles logcheck plus facilement
author: Nicolas Ledez
layout: post
guid: http://nicolas.ledez.free.fr/blog/?p=41
permalink: /informatique/tips/comment-tester-ses-regles-logcheck-plus-facilement/
categories:
  - Tips
---
Par exemple en ce moment j&rsquo;ai ajouté du filtrage sur mon postfix, ce qui génère des logs inhabituel pour la configuration par défaut.

Le plus dur est de construire la bonne règle et la tester.

Voici ma méthode :

{% highlight text %}
STRING="E1B6E2A8BAE";LOG=/var/log/syslog;FILE=logcheck-postfix;vi $FILE ;clear;grep "$STRING" $LOG;echo '-----------------------------------------------';grep "$STRING" $LOG|grep -E -f $FILE
{% endhighlight %}

Ce qui donne si ma règle est bonne:

{% highlight text %}
Dec  8 21:29:02 largo postfix/smtpd[4210]: E1B6E2A8BAE: client=OFSfa-08p4-52.ppp11.odn.ad.jp[211.3.115.52]
Dec  8 21:29:03 largo postfix/cleanup[4223]: E1B6E2A8BAE: message-id=20061209055043.93457mail@mail.rltiurdtiurytryntrdsutbysdutysdtsyvtkx.com
Dec  8 21:29:03 largo postfix/cleanup[4223]: E1B6E2A8BAE: reject: header Content-Type: text/plain;??charset="iso-2022-jp" from OFSfa-08p4-52.ppp11.odn.ad.jp[211.3.115.52]; from=<vcxjwe97984gfd@lycos.com> to=<moi@chezmoi> proto=SMTP helo=<rltiurdtiurytryntrdsutbysdutysdtsyvtkx.com>: 5.7.1 I don't speak japanese
-----------------------------------------------
Dec  8 21:29:03 largo postfix/cleanup[4223]: E1B6E2A8BAE: reject: header Content-Type: text/plain;??charset="iso-2022-jp" from OFSfa-08p4-52.ppp11.odn.ad.jp[211.3.115.52]; from=<vcxjwe97984gfd@lycos.com> to=<moi@chezmoi> proto=SMTP helo=<rltiurdtiurytryntrdsutbysdutysdtsyvtkx.com>: 5.7.1 I don't speak japanese
{% endhighlight %}

Sinon :

{% highlight text %}
Dec  8 21:29:02 largo postfix/smtpd[4210]: E1B6E2A8BAE: client=OFSfa-08p4-52.ppp11.odn.ad.jp[211.3.115.52]
Dec  8 21:29:03 largo postfix/cleanup[4223]: E1B6E2A8BAE: message-id=20061209055043.93457mail@mail.rltiurdtiurytryntrdsutbysdutysdtsyvtkx.com
Dec  8 21:29:03 largo postfix/cleanup[4223]: E1B6E2A8BAE: reject: header Content-Type: text/plain;??charset="iso-2022-jp" from OFSfa-08p4-52.ppp11.odn.ad.jp[211.3.115.52]; from=<vcxjwe97984gfd@lycos.com> to=<moi@chezmoi> proto=SMTP helo=<rltiurdtiurytryntrdsutbysdutysdtsyvtkx.com>: 5.7.1 I don't speak japanese
-----------------------------------------------
{% endhighlight %}
