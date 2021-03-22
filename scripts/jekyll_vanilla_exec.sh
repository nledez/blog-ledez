#!/bin/bash
BASE=$(dirname $0)

if [ ! -f $BASE/jekyll_envs.sh ]; then
	echo "$BASE/jekyll_envs.sh is missing"
	exit 1
else
	. $BASE/jekyll_envs.sh
fi

docker run --rm -it jekyll/builder:$JEKYLL_VERSION "$*"
