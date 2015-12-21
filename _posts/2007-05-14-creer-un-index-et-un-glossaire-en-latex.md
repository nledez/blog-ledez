---
id: 52
title: Créer un index et un glossaire en Latex
author: Nicolas Ledez
layout: post
guid: http://nicolas.ledez.free.fr/blog/index.php/52/2007/05/14/creer-un-index-et-un-glossaire-en-latex/
permalink: /informatique/creer-un-index-et-un-glossaire-en-latex/
categories:
  - Informatique
---
Dans les entête du fichier .tex :

{% highlight latex %}
% Pour l'index
makeindex
%index{Titre a placer dans l'index}

% Pour le glossaire
usepackage[french]{nomencl}
makenomenclature
renewcommand*{nomname}{Glossaire}
%nomenclature{Mot}{Definition.}
{% endhighlight %}

Dans le corps du fichier .tex :

{% highlight latex %}
addcontentsline{toc}{section}{Glossaire}
printnomenclature

addcontentsline{toc}{section}{Index}
printindex
{% endhighlight %}

Et le fichier pour générer le PDF :

{% highlight bash %}
#!/bin/sh
# $Revision: 1.2 $
# Nicolas Ledez
#
# DESCRIPTION:
# USAGE:
# LICENSE: GPL

DOC="ReverseEngineering"
TEX="${DOC}.tex"
LOG="make.log"

date > ${LOG}

texi2pdf ${TEX} &&
makeindex -s index.ist ${DOC} &&
makeindex "${DOC}.nlo" -s "nomencl.ist" -o "${DOC}.nls"  &&
texi2pdf ${TEX} &&
texi2pdf ${TEX} &&
open ${DOC}.pdf >> ${LOG}

date >> ${LOG}
{% endhighlight %}
