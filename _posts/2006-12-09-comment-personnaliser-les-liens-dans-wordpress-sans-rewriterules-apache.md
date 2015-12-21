---
id: 42
title: Comment personnaliser les liens dans wordpress sans RewriteRules Apache
author: Nicolas Ledez
layout: post
guid: http://nicolas.ledez.free.fr/blog/?p=42/2006/12/09/comment-personnaliser-les-liens-dans-wordpress-sans-rewriterules-apache/
permalink: /blog/comment-personnaliser-les-liens-dans-wordpress-sans-rewriterules-apache/
categories:
  - Blog
  - Tips
---
Je voulais utiliser ce type d&rsquo;URL dans WordPress :  
/?p=%post_id%/%year%/%monthnum%/%day%/%postname%/

Je vais donc dans la partie d&rsquo;admin de WordPress :  
http://nicolas.ledez.free.fr/blog/monadminamoi/options-permalink.php

Et je met la bonne syntaxe dans &laquo;&nbsp;Custom structure&nbsp;&raquo; puis clique sur : &laquo;&nbsp;Update Permalink Structure&nbsp;&raquo;

Boum &laquo;&nbsp;500 Internal Server Error&nbsp;&raquo;.

Je trouve pourquoi et supprime le fichier .htaccess (free.fr ne supporte pas les rewrite rules d&rsquo;Apache dans un fichier .htaccess) je recharge ma page :

Warning: preg_match() [function.preg-match]: Compilation failed: nothing to repeat at offset 1 in /mnt/127/sdb/5/6/nicolas.ledez/blog/wp-includes/classes.php on line 1554

Warning: preg_match() [function.preg-match]: Compilation failed: nothing to repeat at offset 1 in /mnt/127/sdb/5/6/nicolas.ledez/blog/wp-includes/classes.php on line 1555

Comme je n&rsquo;ai changé que les permalink, et que je n&rsquo;arrive plus à me connecter non plus à la partie admin, je cherche dans les options contenus dans la base de donnée. Je trouve, donc j&rsquo;essaye ça :  
UPDATE \`wp\_options\` SET \`option\_value\` = &lsquo;/?p=%post\_id%/%year%/%monthnum%/%day%/%postname%/&rsquo; WHERE \`option\_name\` =&rsquo;permalink\_structure&rsquo; AND \`blog\_id\` =0;

Encore l&rsquo;erreur PHP !!!

Grrr, Ok donc je passe en mode neuneu :

Je teste avec :  
/%post_id%  
Ok  
/?p=%post_id%  
Ok  
/?p=%post_id%/%year%/%monthnum%/%day%/%postname%/  
Ok !!!!! Yeessss !!!!!  
Pourquoi ??? Aucune idée, par contre ça marche&#8230;

J&rsquo;ai essayé en mettant directement la syntaxe complète, mais ça ne marche pas non plus&#8230;

Correctif : ça à l&rsquo;air de mieux marcher avec :

/index.php?p=%post_id%/%year%/%monthnum%/%day%/%postname%/

Correctif 2 : ça marche encore mieux avec ça :

/index.php/%post_id%/%year%/%monthnum%/%day%/%postname%/

Trouvé sur : http://jeanjerome.free.fr/?p=10