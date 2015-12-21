---
id: 45
title: Ne plus taper les mots de passe ftp avec les programme Unix
author: Nicolas Ledez
layout: post
guid: http://nicolas.ledez.free.fr/blog/index.php/index.php?p=45/2006/12/11/ne-plus-taper-les-mots-de-passe-ftp-avec-les-programme-unix/
permalink: /informatique/tips/ne-plus-taper-les-mots-de-passe-ftp-avec-les-programme-unix/
categories:
  - Tips
---
Creer un fichier ~.netrc :

<pre>NETRC							<span class="Constant"><a name="netrw-netrc" />*netrw-netrc*</span>

La syntaxe typique des lignes d'un fichier ".netrc" est donnée ci-dessous.
Les clients FTP sous Unix supporte généralement le fichier ".netrc". Le client
`ftp` de MS-Windows généralement pas.
<span class="Comment">
machine {NomCompletDeLHôte} login <span class="Special">{NomUtilisateur}</span> password <span class="Special">{MotDePasse}</span>
default		      login <span class="Special">{NomUtilisateur}</span> password <span class="Special">{MotDePasse}</span>
</span></pre>

ne remplacer que les partie en {}, le reste est important.

Source : <http://vim.dindinx.net/traduit/html/pi_netrw.txt.php>  
Et miracle, on ne tape plus les mot de passe, testé avec vim et lftp.