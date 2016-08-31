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

{% highlight bash %}
apt-get install cyrus-nntpd-2.2
{% endhighlight %}

In a directory (such as home directory). You can launch it as normal user. It&rsquo;s to get tools scripts  

{% highlight bash %}
apt-get source cyrus-imapd-2.2
vi /etc/cyrus.conf
{% endhighlight %}

uncomment nntp lines

{% highlight bash %}
vi /etc/imapd.conf
{% endhighlight %}

add :

{% highlight bash %}
newsprefix: news
{% endhighlight %}

Restart cyrus

get mknewsgroups script

{% highlight bash %}
wget ftp://ftp.isc.org/usenet/CONFIG/active
./mknewsgroups -n -u cyrus -w fr.comp.text.tex -a "anyone +p news write" localhost
{% endhighlight %}

you get this :

{% highlight bash %}
reading configure file...
you are using "news" as your news prefix.
done
C01 CREATE "news.fr.comp.text.tex"
S01 SETACL "news.fr.comp.text.tex" news write
S02 SETACL "news.fr.comp.text.tex" anyone +p
{% endhighlight %}

If you think it&rsquo;s ok :

{% highlight bash %}
./mknewsgroups -u cyrus -w fr.comp.text.tex -a "anyone +p news write" localhost
{% endhighlight %}

{% highlight bash %}
cat /usr/local/bin/cyrus-fetchnews
#! /bin/sh

CONF="/etc/news-cyrus-abo"

env &gt; /tmp/cyfetch

if [ ! -f ${CONF} ]; then
echo "${CONF} missing..."
exit 1
fi

if [[ ${LOGNAME} != "cyrus" ]]; then
echo "Must be run as cyrus User"
exit 2
fi

source ${CONF}

for ng in ${ABO_GROUPS}; do
/usr/lib/cyrus/bin/fetchnews ${OPTIONS} -w ${ng} ${SERVER}
done
cat /etc/news-cyrus-abo
SERVER="news.free.fr"
OPTIONS="-n -y"
ABO_GROUPS="fr.comp.text.tex comp.text.tex"

cat /etc/cron.d/cyr-newsgroup
MAILTO=root

*/5 * * * * cyrus /usr/local/bin/cyrus-fetchnews
0 0 * * * cyrus /usr/sbin/cyr_expire -E 60 -v

mboxcfg news expire 60
{% endhighlight %}

& to check it :

{% highlight bash %}
localhost.localdomain> info news  
{news}:  
expire: 60  
lastpop:  
lastupdate: 16-Feb-2007 09:46:58 +0100  
partition: default  
size: 0
{% endhighlight %}

It&rsquo;s done 😉 & now you can view newsgroup in you favorite IMAP client.

 [1]: http://cyrusimap.web.cmu.edu/
 [2]: http://fofredux.sf.net/ "fofredux"
