---
id: 40
title: Trouver ce qui prend de la place dans /
author: Nicolas Ledez
layout: post
guid: http://nicolas.ledez.free.fr/blog/?p=40
permalink: /informatique/tips/trouver-ce-qui-prend-de-la-place-dans/
categories:
  - Tips
---
Comment trouver ce qui prend de la place dans / (sous Unix, et en particulier Solaris).

D&rsquo;habitude, j&rsquo;utilise la commande suivante (sous Linux) :

{% highlight bash %}
    du -ksx *|sort -n|awk '{print $2}'|xargs du -hsx
{% endhighlight %}

Explications :

Afficher tous les répertoires/fichiers avec leurs tailles tout en restant dans le même système de fichier, puis trier numériquement, puis ne garder que la deuxième partie de la ligne (awk), et enfin on recalcule les tailles et on les affichent dans un format humainement lisible (Go/Mo/Ko/O).

En gros je lance la commande, je vais là où ça me parait suspect (cd quoi) , et je relance la commande, etc

Tous ça marche bien jusqu&rsquo;au moment ou on travaille dans / avec de multiple points de montages.

Le script suivant marche dans / sous Solaris :

Je cherche tous les points de montages à la racine en enlevant le / du début :

{% highlight bash %}
    MOUNTED=`mount|awk '$1 !~ /\/.*\// {print $1}'|sed 's#^/##'`
{% endhighlight %}

Je liste tout à la racine :

{% highlight bash %}
    ALL=`ls /`
{% endhighlight %}

J&rsquo;initialise la variable NOTMOUNTPOINT :

{% highlight bash %}
    NOTMOUNTPOINT=""
{% endhighlight %}

Pour tous les fichiers/répertoire faire :

{% highlight bash %}
    for i in $ALL;do
{% endhighlight %}

Si l&rsquo;élément courant n&rsquo;est pas un point de montage, l&rsquo;ajouter à la liste NOTMOUNTPOINT :

{% highlight bash %}
    echo $MOUNTED|grep -c $i > /dev/null; if [[ $? == 1 ]]; then NOTMOUNTPOINT="$NOTMOUNTPOINT $i";fi;done
{% endhighlight %}

Et ensuite avec la même méthode qu&rsquo;au dessus, afficher les tailles des répertoires :

{% highlight bash %}
    echo $NOTMOUNTPOINT|xargs du -ksd|sort -n|awk '{print $2}'|xargs du -hsd
{% endhighlight %}

Ce qui donne en une seule ligne :

{% highlight bash %}
    MOUNTED=`mount|awk '$1 !~ /\/.*\// {print $1}'|sed 's/^\///'`;ALL=`ls /`;NOTMOUNTPOINT="";for i in $ALL;do echo $MOUNTED|grep -c $i > /dev/null; if [[ $? == 1 ]]; then NOTMOUNTPOINT="$NOTMOUNTPOINT $i";fi;done;echo $NOTMOUNTPOINT|xargs du -ksd|sort -n|awk '{print $2}'|xargs du -hsd
{% endhighlight %}
