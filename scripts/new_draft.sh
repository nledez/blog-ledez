#!/bin/sh

if [ -z "$1" ]; then
	echo "Usage: provide a title argument."
	exit -1
else
	title="$@"
fi

# Slugify, inspired by https://github.com/benlinton/bash-slugify/blob/master/slugify
slug=$(echo "$title" | tr "[:upper:]" "[:lower:]")
slug=$(echo "$slug" | sed "y/āáǎàēéěèīíǐìōóǒòūúǔùǖǘǚǜĀÁǍÀĒÉĚÈĪÍǏÌŌÓǑÒŪÚǓÙǕǗǙǛ/aaaaeeeeiiiioooouuuuüüüüAAAAEEEEIIIIOOOOUUUUÜÜÜÜ/")
slug=$(echo "$slug" | tr "[:punct:]" " ")
slug=$(echo "$slug" | tr _ " ")
slug=$(echo "$slug" | tr - " ")
slug=$(echo "$slug" | tr -s " ")
slug=$(echo "$slug" | tr "[:space:]" "-")
slug="${slug:0:${#slug}-1}"

post="./_drafts/${slug}.md"
echo $post

body=""
read -d '' body <<EOF
---
title: $title
lang: fr
layout: post
permalink: /${slug}/
categories: [ ]
tags:  [ ]
excerpt_separator: <!--more-->
---

EOF

echo "$body" > "$post"

/Applications/MacDown.app/Contents/MacOS/MacDown "$post" &
