#!/bin/sh
if [ -z "$1" ]; then
	echo "Usage: provide a title argument."
	exit -1
else
	title="$@"
fi

# Slugify, inspired by https://github.com/benlinton/bash-slugify/blob/master/slugify
slug=$(echo "$title" | tr "[:upper:]" "[:lower:]")
# slug=$(echo "$slug" | sed "y/àéèê/aeee/")
slug=$(echo "$slug" | tr "[:punct:]" " ")
slug=$(echo "$slug" | tr _ " ")
slug=$(echo "$slug" | tr - " ")
slug=$(echo "$slug" | tr -s " ")
slug=$(echo "$slug" | tr "[:space:]" "-")
slug="${slug:0:${#slug}-1}"

date=`date +%Y-%m-%d`

post="./_drafts/${slug}.md"
echo $post

body=""
read -d '' body <<EOF
---
date: $date
title: $title
lang: fr
layout: post
permalink: /${slug}/
categories:
  - Informatique
tags:
  - Informatique
excerpt_separator: <!--more-->
---

![Illustation blabla]({{ site.url }}/images/202X/xx/image.jpg)

<!--more-->
EOF

echo "$body" > "$post"

# /Applications/MacDown.app/Contents/MacOS/MacDown "$post" &
