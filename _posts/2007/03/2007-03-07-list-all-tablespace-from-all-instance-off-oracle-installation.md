---
id: 51
title: List all tablespace from all instance off Oracle installation
author: Nicolas Ledez
layout: post
guid: http://nicolas.ledez.free.fr/blog/index.php/51/2007/03/07/list-all-tablespace-from-all-instance-off-oracle-installation/
permalink: /informatique/tips/list-all-tablespace-from-all-instance-off-oracle-installation/
categories:
  - Tips
---
Run this script :

{% highlight bash %}
#! /bin/bash
SID_LIST=`cat /var/opt/oracle/oratab |egrep -v '^(#|$|*)'|cut -f1 -d:`
for sid in $SID_LIST; do
echo " ===== $sid ===== "
su - ora920 -c "export ORACLE_SID=$sid;echo 'select file_name from dba_data_files;'|sqlplus '/ as sysdba'"|egrep '^/'|cut -f5 -d'/'
done
{% endhighlight %}
