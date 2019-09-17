#!/bin/bash
BASE=$(dirname $0)

if [ ! -f $BASE/jekyll_envs.sh ]; then
	echo "$BASE/jekyll_envs.sh is missing"
	exit 1
else
	. $BASE/jekyll_envs.sh
fi

docker run --rm --volume="$PWD:/srv/jekyll" --volume="$PWD/.vendor/bundle:/usr/local/bundle" --publish 0.0.0.0:4000:4000 -it jekyll/builder:$JEKYLL_VERSION jekyll serve --config _config.yml,_config-dev.yml --watch --drafts --unpublished --incremental
