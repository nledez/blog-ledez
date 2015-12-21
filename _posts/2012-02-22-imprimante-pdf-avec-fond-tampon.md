---
id: 453
title: Imprimante PDF avec fond/tampon
author: Nicolas Ledez
layout: post
guid: http://blog.ledez.net/?p=453
permalink: /informatique/tips/imprimante-pdf-avec-fond-tampon/
categories:
  - Tips
tags:
  - automator
  - mac
  - osx
  - pdf
---
  1. Chalenge de la journée : réussir à trouver une solution pour transformer un document Word en PDF avec &laquo;&nbsp;papier à entête&nbsp;&raquo;

Coup de bol c&rsquo;est sur Mac <img src="https://blog.ledez.net/wp-includes/images/smilies/simple-smile.png" alt=":)" class="wp-smiley" style="height: 1em; max-height: 1em;" />  
<!--more-->

### Etape 1 : transformer un PDF en PDF avec fond de page

J&rsquo;ai trouvé [pdftk][1] qui permet de travailler le PDF, le couteau suisse du PDF quoi&#8230; En plus avec un logo hyper sexy :

<img class="alignnone size-medium wp-image-454" title="pdftk-logo" src="http://blog.ledez.net/wp-content/uploads/2012/02/pdftk-logo.png" alt="Logo pdftk" />

<img src="https://blog.ledez.net/wp-includes/images/smilies/simple-smile.png" alt=":)" class="wp-smiley" style="height: 1em; max-height: 1em;" />

$doc_source est le document que je veux transformer.

$stamp est le document que je veux utiliser pour mettre en fond.

Stamp -> en premier plan, background -> en fond.

Le script suivant va transformer le document avec le fichier $stamp en premier plan :

<div class="codecolorer-container bash default" style="overflow:auto;white-space:nowrap;">
  <div class="bash codecolorer">
    <span class="re2">pdftk</span>=<span class="sy0">/</span>usr<span class="sy0">/</span>local<span class="sy0">/</span>bin<span class="sy0">/</span>pdftk<br /> <span class="re1">$pdftk</span> <span class="st0">"<span class="es2">$doc_source</span>"</span> stamp <span class="st0">"<span class="es2">$stamp</span>"</span> output <span class="st0">"<span class="es2">$dest</span>"</span>
  </div>
</div>

Un peu plus long, transformer le document avec $stamp en fond, mais que sur la première page :

<div class="codecolorer-container bash default" style="overflow:auto;white-space:nowrap;">
  <div class="bash codecolorer">
    <span class="co4">$</span>pdftk <span class="st0">"<span class="es2">$doc_source</span>"</span> <span class="kw2">cat</span> <span class="nu0">1</span> output - <span class="sy0">|</span> <span class="re1">$pdftk</span> - background <span class="st0">"<span class="es2">$stamp</span>"</span> output - <span class="sy0">|</span> <span class="re1">$pdftk</span> <span class="re2">A</span>=- <span class="re2">B</span>=<span class="st0">"<span class="es2">$doc_source</span>"</span> <span class="kw2">cat</span> A1 B2-end output <span class="st0">"<span class="es2">$dest</span>"</span>
  </div>
</div>

### Etape 2 : automatiser un peu tout ça

[<img class="alignleft  wp-image-458" title="Automator" src="http://blog.ledez.net/wp-content/uploads/2012/02/Automator-300x300.png" alt="Logo Automator" width="180" height="180" srcset="http://blog.ledez.net/wp-content/uploads/2012/02/Automator-150x150.png 150w, http://blog.ledez.net/wp-content/uploads/2012/02/Automator-300x300.png 300w, http://blog.ledez.net/wp-content/uploads/2012/02/Automator.png 512w" sizes="(max-width: 180px) 100vw, 180px" />][2][Automator][3] est fait pour ça non ?

Simple pour automatiser des trucs, super bien intégré. Avec même des fonctionnalités inattendues.

&nbsp;

&nbsp;

&nbsp;

&nbsp;

Créer un nouveau Workflow avec :  
[<img class="alignnone size-full wp-image-460" title="Workflow-01" src="http://blog.ledez.net/wp-content/uploads/2012/02/Workflow-011.png" alt="" width="896" height="555" />][4]

Et le source :

<div class="codecolorer-container bash default" style="overflow:auto;white-space:nowrap;">
  <div class="bash codecolorer">
    <span class="kw3">cd</span> <span class="st0">"/Users/nico/Documents/PDF-Watermark"</span><br /> <span class="re2">pdftk</span>=<span class="sy0">/</span>usr<span class="sy0">/</span>local<span class="sy0">/</span>bin<span class="sy0">/</span>pdftk<br /> <span class="re2">doc_source</span>=<span class="st0">"$1"</span><br /> <span class="re2">stamp</span>=<span class="st0">"Fond-de-page.pdf"</span><br /> <span class="re2">dest</span>=<span class="sy0">`</span><span class="kw3">echo</span> <span class="st0">"<span class="es2">$doc_source</span>"</span> <span class="sy0">|</span> <span class="kw2">sed</span> <span class="re5">-E</span> <span class="st_h">'s/.pdf$/-mail.pdf/'</span><span class="sy0">`</span>
  </div>
</div>

$pdftk &laquo;&nbsp;$doc\_source&nbsp;&raquo; cat 1 output &#8211; | $pdftk &#8211; stamp &laquo;&nbsp;$stamp&nbsp;&raquo; output &#8211; | $pdftk A=- B=&nbsp;&raquo;$doc\_source&nbsp;&raquo; cat A1 B2-end output &laquo;&nbsp;$dest&nbsp;&raquo;

open &laquo;&nbsp;$dest&nbsp;&raquo;

Explications :

  * Je vais dans le répertoire où est mon fond de page
  * Je transforme mon nom de fichier de .pdf en -mail.pdf
  * J&rsquo;utilise pdftk pour transformer mon PDF d&rsquo;origine en PDF avec fond de page
  * Et pour finir j&rsquo;ouvre mon PDF

Je peux maintenant transformer mon workflow en application. Et faire du glisser-déplacer d&rsquo;un PDF sur mon application.

Bon, ça marche par contre :

  1. Imprimer mon document en PDF
  2. Déplacer mon PDF sur mon application

Je suis un peu fainéant moi <img src="https://blog.ledez.net/wp-includes/images/smilies/simple-smile.png" alt=":)" class="wp-smiley" style="height: 1em; max-height: 1em;" />

### Etape 3 : je vous ai bien dit que c&rsquo;était magique ?

Quand on ouvre l&rsquo;application on trouve ça :[<img src="http://blog.ledez.net/wp-content/uploads/2012/02/Workflow-031.png" alt="" title="Workflow-03" width="513" height="292" class="alignnone size-full wp-image-469" />][5]

La petite imprimante doit bien servir à quelque chose <img src="https://blog.ledez.net/wp-includes/images/smilies/simple-smile.png" alt=":)" class="wp-smiley" style="height: 1em; max-height: 1em;" />

Pour éviter de refaire tout mon workflow, je vais le dupliquer :

[<img src="http://blog.ledez.net/wp-content/uploads/2012/02/Workflow-021.png" alt="" title="Workflow-02" width="519" height="299" class="alignnone size-full wp-image-472" />][6]

Ensuite on supprime la première boite qui prend le PDF en paramètre :  
[<img src="http://blog.ledez.net/wp-content/uploads/2012/02/Workflow-04.png" alt="" title="Workflow-04" width="618" height="249" class="alignnone size-full wp-image-470" />][7]

On enregistre le plug-in. La boite de dialogue va simplement demander le nom du plug-in d&rsquo;impression.

Et maintenant pour avoir le document, on va simplement imprimer et dans la liste &laquo;&nbsp;PDF&nbsp;&raquo; on va retrouver notre plug-in <img src="https://blog.ledez.net/wp-includes/images/smilies/simple-smile.png" alt=":)" class="wp-smiley" style="height: 1em; max-height: 1em;" />

 [1]: http://www.pdflabs.com/tools/pdftk-the-pdf-toolkit/ "Site de PDFTK"
 [2]: http://blog.ledez.net/wp-content/uploads/2012/02/Automator.png
 [3]: http://www.apple.com/remotedesktop/automation.html "Site d'Automator"
 [4]: http://blog.ledez.net/wp-content/uploads/2012/02/Workflow-011.png
 [5]: http://blog.ledez.net/wp-content/uploads/2012/02/Workflow-031.png
 [6]: http://blog.ledez.net/wp-content/uploads/2012/02/Workflow-021.png
 [7]: http://blog.ledez.net/wp-content/uploads/2012/02/Workflow-04.png