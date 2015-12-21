---
id: 36
title: 'Tips #2 &#8211; Howto install all Solaris packages from a directory'
author: Nicolas Ledez
layout: post
guid: http://nicolas.ledez.free.fr/blog/2006/11/16/tips-2-howto-install-all-packages-from-a-directory/
permalink: /informatique/tips/tips-2-howto-install-all-packages-from-a-directory/
categories:
  - Tips
---
cd /your/directory  
\# Create a admin file  
cat >> adminfile << "EOF" basedir=default conflict=nocheck setuid=nocheck action=nocheck partial=nocheck instance=overwrite idepend=quit rdepend=quit space=quit EOF # Extract packages for p in \*.gz;do gunzip $p;done # Generate a install file for p in \*-sol9-sparc-local;do pkginfo -d $p|awk '{print "pkgadd -a adminfile -n -d '$p'" " " $2}';done > install_packages.sh

\# Launch install file  
sh install_packages.sh