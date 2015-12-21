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

<div class="codecolorer-container latex default" style="overflow:auto;white-space:nowrap;">
  <div class="latex codecolorer">
    <span class="co1">% Pour l'index</span><br /> makeindex<br /> <span class="co1">%index{Titre a placer dans l'index}</span><br /> <br /> <span class="co1">% Pour le glossaire</span><br /> usepackage<span class="sy0">[</span><span class="re2">french</span><span class="sy0">]{</span><span class="re9">nomencl}<br /> makenomenclature<br /> renewcommand*{nomname}{Glossaire</span><span class="sy0">}</span><br /> <span class="co1">%nomenclature{Mot}{Definition.}</span>
  </div>
</div>

Dans le corps du fichier .tex :

<div class="codecolorer-container latex default" style="overflow:auto;white-space:nowrap;">
  <div class="latex codecolorer">
    addcontentsline<span class="sy0">{</span><span class="re9">toc}{section}{Glossaire}<br /> printnomenclature<br /> <br /> addcontentsline{toc}{section}{Index</span><span class="sy0">}</span><br /> printindex
  </div>
</div>

Et le fichier pour générer le PDF :

<div class="codecolorer-container bash default" style="overflow:auto;white-space:nowrap;">
  <div class="bash codecolorer">
    <span class="co0">#!/bin/sh</span><br /> <span class="co0"># $Revision: 1.2 $</span><br /> <span class="co0"># Nicolas Ledez</span><br /> <span class="co0">#</span><br /> <span class="co0"># DESCRIPTION:</span><br /> <span class="co0"># USAGE:</span><br /> <span class="co0"># LICENSE: GPL</span><br /> <br /> <span class="re2">DOC</span>=<span class="st0">"ReverseEngineering"</span><br /> <span class="re2">TEX</span>=<span class="st0">"<span class="es3">${DOC}</span>.tex"</span><br /> <span class="re2">LOG</span>=<span class="st0">"make.log"</span><br /> <br /> <span class="kw2">date</span> <span class="sy0">></span> <span class="co1">${LOG}</span><br /> <br /> texi2pdf <span class="co1">${TEX}</span> <span class="sy0">&&</span><br /> makeindex <span class="re5">-s</span> index.ist <span class="co1">${DOC}</span> <span class="sy0">&&</span><br /> makeindex <span class="st0">"<span class="es3">${DOC}</span>.nlo"</span> <span class="re5">-s</span> <span class="st0">"nomencl.ist"</span> <span class="re5">-o</span> <span class="st0">"<span class="es3">${DOC}</span>.nls"</span> &nbsp;<span class="sy0">&&</span><br /> texi2pdf <span class="co1">${TEX}</span> <span class="sy0">&&</span><br /> texi2pdf <span class="co1">${TEX}</span> <span class="sy0">&&</span><br /> open <span class="co1">${DOC}</span>.pdf <span class="sy0">>></span> <span class="co1">${LOG}</span><br /> <br /> <span class="kw2">date</span> <span class="sy0">>></span> <span class="co1">${LOG}</span>
  </div>
</div>