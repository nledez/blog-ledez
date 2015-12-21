---
id: 95
title: 'Cacti &#8211; Renommer un &laquo;&nbsp;Internal Data Source Name&nbsp;&raquo; dans un &laquo;&nbsp;Data Templates&nbsp;&raquo;'
author: Nicolas Ledez
layout: post
guid: http://nicolas.ledez.free.fr/blog/?p=95
permalink: /divers/cacti-renommer-un-internal-data-source-name-dans-un-data-templates/
categories:
  - Divers
  - Informatique
  - OpenSource
  - Tips
tags:
  - cacti
  - howto
  - linux
  - tips
---
Ne pas renommer comme un bourrin, c&rsquo;est utilisé dans les RRA (fichier rrd).

1- chercher dans &laquo;&nbsp;Data Source&nbsp;&raquo; celles qui correspondent au template  
2- ouvrir toutes les occurrences (s&rsquo;il n&rsquo;y en a pas faire 6 et 8 )  
2a &#8211; ouvrir un graphique qui affiche cette valeur  
3- noter les &laquo;&nbsp;Data Source Path&nbsp;&raquo; (<path_rra>/blablabla.rrd  
4- se positionner dans <path_rra>  
5- lancer &laquo;&nbsp;for f in fichier1.rrd fichier2.rrd;do rrdtool info $f|grep -E &lsquo;^ds&rsquo;;done&nbsp;&raquo; qui doit afficher :  
ds[ancien nom]  
6- préparer dans une fenêtre la modification du &laquo;&nbsp;Data Templates&nbsp;&raquo; avec son nouveau &laquo;&nbsp;Internal Data Source Name&nbsp;&raquo; (ne pas valider)  
7- lancer &laquo;&nbsp;for f in fichier1.rrd fichier2.rrd;do rrdtool tune $f -r ancien\_nom:nouveau\_nom;done&nbsp;&raquo;  
7a- relancer le 5 pour valider le changement  
8- valider la fenêtre &laquo;&nbsp;Data Templates&nbsp;&raquo; avec son nouveau &laquo;&nbsp;Internal Data Source Name&nbsp;&raquo;  
8b- recharger la fenêtre du 2a

Et voila