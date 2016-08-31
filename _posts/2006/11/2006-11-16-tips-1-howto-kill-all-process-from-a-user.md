---
id: 35
title: 'Tips #1 &#8211; Howto kill all process from a user'
author: Nicolas Ledez
layout: post
guid: http://nicolas.ledez.free.fr/blog/2006/11/16/tips-1-howto-kill-all-process-from-a-user/
permalink: /informatique/tips/tips-1-howto-kill-all-process-from-a-user/
categories:
  - Tips
---
for p in \`ps -o pid -u auser\`;do if [[ &laquo;&nbsp;$p&nbsp;&raquo; != &laquo;&nbsp;PID&nbsp;&raquo; ]]; then echo kill $p ; fi ; done  
\# Change auser to your user (not root 😉 & change &laquo;&nbsp;echo kill&nbsp;&raquo; by &laquo;&nbsp;kill&nbsp;&raquo; or &laquo;&nbsp;kill  -9&nbsp;&raquo; 😉