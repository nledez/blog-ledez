#!/bin/bash
BASE=$(dirname $0)
RSYNC_SRC="_site_prod/"
RSYNC_DST="nerio.ledez.net:/var/www/blog.ledez.net/"
RSYNC_OPTS="-av --delete-after"

if [ ! -f $BASE/jekyll_envs.sh ]; then
	echo "$BASE/jekyll_envs.sh is missing"
	exit 1
else
	. $BASE/jekyll_envs.sh
fi

if [ ! -d $RSYNC_SRC ]; then
	echo "$RSYNC_SRC is missing"
	exit 1
fi

docker run --rm --volume="$PWD:/srv/jekyll" --volume="$PWD/_site_prod:/srv/jekyll/_site" --volume="$PWD/.vendor/bundle:/usr/local/bundle" -it jekyll/builder:$JEKYLL_VERSION jekyll build --config _config.yml

rsync --dry-run ${RSYNC_OPTS} ${RSYNC_SRC} ${RSYNC_DST}
echo "Sync & abort? (Ctrl-C)"
read
rsync ${RSYNC_OPTS} ${RSYNC_SRC} ${RSYNC_DST}

echo
echo 'https://blog.ledez.net'
