new_post:
	#!/usr/bin/bash
	# Requires https://gitee.com/mirrors/hanz2piny
	while [ -z $title ]; do
		read -p "请输入文章标题：" title
	done
	# Generate pinyin for title
	TMPFILE=/tmp/_tmp_$(uuidgen).txt
	echo $title > $TMPFILE
	TITLE_PINYIN=$(hanz2piny --path $TMPFILE | sed 's/[^a-zA-Z0-9]\+/-/g' | head -c 20)
	rm $TMPFILE
	POST_TITLE=$(date +%Y%m%d)_${TITLE_PINYIN}
	# Generate new post
	hugo new posts/${POST_TITLE}/index.md
	sed -i "s/${POST_TITLE}/$title/" content/posts/${POST_TITLE}/index.md
	Thunar content/posts/${POST_TITLE}

serve:
	#!/usr/bin/bash
	(sleep 2 && firefox http://localhost:1313) &!
	hugo server -D

update_theme:
	git submodule update --remote --merge

compress_picture MAXK="1000":
	fd '\.(jpg|jpeg|png|bmp)' content -x bash -c 'if [ $(du -k {} | cut -f1) -gt {{MAXK}} ]; then convert -quality 60 -resize 800x800 {} /tmp/{/} && mv /tmp/{/} {}; fi'

commit: compress_picture
	git add -u
	git add content
	git commit -m "Update $(date -I)"
