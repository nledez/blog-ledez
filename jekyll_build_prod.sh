#!/bin/bash
BASE=$(dirname $0)

if [ ! -f $BASE/jekyll_envs.sh ]; then
	echo "$BASE/jekyll_envs.sh is missing"
	exit 1
else
	. $BASE/jekyll_envs.sh
fi

docker run --rm --volume="$PWD:/srv/jekyll" --volume="$PWD/_site_prod:/srv/jekyll/_site" --volume="$PWD/.vendor/bundle:/usr/local/bundle" -it jekyll/builder:$JEKYLL_VERSION jekyll build --config _config.yml
