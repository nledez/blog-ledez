---
id: 37
title: 'Tips #3 &#8211; Show only CPU from a prtdiag / show lines between two paterns'
author: Nicolas Ledez
layout: post
guid: http://nicolas.ledez.free.fr/blog/?p=37
permalink: /informatique/tips/tips-3-show-only-cpu-from-a-prtdiag-show-lines-between-two-paterns/
categories:
  - Tips
---
prtdiag | awk &lsquo;BEGIN{$CPU=0} /^===/{$CPU=0} /^===.* CPUs/{$CPU=1} $CPU==1{print $0}&rsquo;