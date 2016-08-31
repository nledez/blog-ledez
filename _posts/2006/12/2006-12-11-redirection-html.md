---
id: 43
title: Redirection HTML
author: Nicolas Ledez
layout: post
guid: http://nicolas.ledez.free.fr/blog/?p=43/2006/12/11/redirection-html/
permalink: /informatique/tips/redirection-html/
categories:
  - Tips
---
{% highlight html %}
    <?xml version="1.0" encoding="ISO-8859-1"?>
    <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
    <html xmlns="http://www.w3.org/1999/xhtml">
    <head>
    <meta http-equiv="content-type" content="text/html; charset=ISO-8859-1" /><meta http-equiv="refresh" content="0; url=http://nouvelle.adresse.fr/dossier2/page2.html" />
    <title>Redirection</title>
    <meta name="robots" content="noindex,follow" />
    </head>
    
    <body>
    <p><a xhref="http://nouvelle.adresse.fr/dossier2/page2.html" mce_href="http://nouvelle.adresse.fr/dossier2/page2.html">Redirection</a></p>
    </body>
    </html>
{% endhighlight %}

Plus de détails ici : <http://alexandre.alapetite.net/doc-alex/redirections/index.fr.html>
