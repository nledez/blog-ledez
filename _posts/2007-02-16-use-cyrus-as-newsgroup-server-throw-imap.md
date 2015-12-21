---
id: 50
title: 'Use cyrus as &laquo;&nbsp;newsgroup server&nbsp;&raquo; throw IMAP'
author: Nicolas Ledez
layout: post
guid: http://nicolas.ledez.free.fr/blog/index.php/50/2007/02/16/use-cyrus-as-newsgroup-server-throw-imap/
permalink: /informatique/use-cyrus-as-newsgroup-server-throw-imap/
categories:
  - Informatique
  - OpenSource
---
If you have a [cyrus-imap][1] was installed, you can use it as &laquo;&nbsp;nntp reader&nbsp;&raquo; (all examples are with a Debian Etch).  
My problem is : I have many computer where I read my mail, blog (rss) and now newsgroup.

For my mails, I use a IMAP server ([cyrus-imap][1]), for my rss I use [FoFRedux][2] and now I search a solution for read newsgroup.

Now with [cyrus-imap][1] you can feed newsgroup in NNTP :

<div class="codecolorer-container text default" style="overflow:auto;white-space:nowrap;">
  <div class="text codecolorer">
    apt-get install cyrus-nntpd-2.2
  </div>
</div>

In a directory (such as home directory). You can launch it as normal user. It&rsquo;s to get tools scripts  
apt-get source cyrus-imapd-2.2

<div class="codecolorer-container text default" style="overflow:auto;white-space:nowrap;">
  <div class="text codecolorer">
    vi /etc/cyrus.conf
  </div>
</div>

uncomment nntp lines

<div class="codecolorer-container text default" style="overflow:auto;white-space:nowrap;">
  <div class="text codecolorer">
    vi /etc/imapd.conf
  </div>
</div>

add :

<div class="codecolorer-container text default" style="overflow:auto;white-space:nowrap;">
  <div class="text codecolorer">
    newsprefix: news
  </div>
</div>

Restart cyrus

get mknewsgroups script

<div class="codecolorer-container text default" style="overflow:auto;white-space:nowrap;">
  <div class="text codecolorer">
    wget ftp://ftp.isc.org/usenet/CONFIG/active
  </div>
</div>

<div class="codecolorer-container text default" style="overflow:auto;white-space:nowrap;">
  <div class="text codecolorer">
    ./mknewsgroups -n -u cyrus -w fr.comp.text.tex -a "anyone +p news write" localhost
  </div>
</div>

you get this :

<div class="codecolorer-container text default" style="overflow:auto;white-space:nowrap;">
  <div class="text codecolorer">
    reading configure file...<br /> you are using "news" as your news prefix.<br /> done<br /> C01 CREATE "news.fr.comp.text.tex"<br /> S01 SETACL "news.fr.comp.text.tex" news write<br /> S02 SETACL "news.fr.comp.text.tex" anyone +p
  </div>
</div>

If you think it&rsquo;s ok :

<div class="codecolorer-container text default" style="overflow:auto;white-space:nowrap;">
  <div class="text codecolorer">
    ./mknewsgroups -u cyrus -w fr.comp.text.tex -a "anyone +p news write" localhost
  </div>
</div>

<div class="codecolorer-container text default" style="overflow:auto;white-space:nowrap;">
  <div class="text codecolorer">
    cat /usr/local/bin/cyrus-fetchnews<br /> #! /bin/sh<br /> <br /> CONF="/etc/news-cyrus-abo"<br /> <br /> env > /tmp/cyfetch<br /> <br /> if [ ! -f ${CONF} ]; then<br /> echo "${CONF} missing..."<br /> exit 1<br /> fi<br /> <br /> if [[ ${LOGNAME} != "cyrus" ]]; then<br /> echo "Must be run as cyrus User"<br /> exit 2<br /> fi<br /> <br /> source ${CONF}<br /> <br /> for ng in ${ABO_GROUPS}; do<br /> /usr/lib/cyrus/bin/fetchnews ${OPTIONS} -w ${ng} ${SERVER}<br /> done<br /> cat /etc/news-cyrus-abo<br /> SERVER="news.free.fr"<br /> OPTIONS="-n -y"<br /> ABO_GROUPS="fr.comp.text.tex comp.text.tex"<br /> <br /> cat /etc/cron.d/cyr-newsgroup<br /> MAILTO=root<br /> <br /> */5 * * * * cyrus /usr/local/bin/cyrus-fetchnews<br /> 0 0 * * * cyrus /usr/sbin/cyr_expire -E 60 -v<br /> To delete old articles :<br /> <code><br /> cyradm -u cyrus localhost
  </div>
</div>

mboxcfg news expire 60

& to check it :

localhost.localdomain> info news  
{news}:  
expire: 60  
lastpop:  
lastupdate: 16-Feb-2007 09:46:58 +0100  
partition: default  
size: 0

It&rsquo;s done 😉 & now you can view newsgroup in you favorite IMAP client.

 [1]: http://cyrusimap.web.cmu.edu/
 [2]: http://fofredux.sf.net/ "fofredux"