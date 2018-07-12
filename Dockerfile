FROM rocketchat/hubot-rocketchat:latest
MAINTAINER himmel17
LABEL title="hubot-rocketchat"
LABEL version="0.2"
LABEL description="社内proxy越しにnpmがうまくいかないのでDockerHubでカスタムイメージ作成．hubot-rss-readerを追加．"

ENV EXTERNAL_SCRIPTS=hubot-diagnostics,hubot-help,hubot-google-images,hubot-google-translate,hubot-pugme,hubot-maps,hubot-rules,hubot-shipit,hubot-seen,hubot-links,hubot-mongodb-brain,hubot-rss-reader

# ENV BOT_NAME "rocketbot"
ENV BOT_NAME "bot"
ENV BOT_OWNER "No owner specified"
ENV BOT_DESC "Hubot with rocketbot adapter"

USER hubot
WORKDIR /home/hubot

RUN cd /home/hubot/node_modules/hubot-rocketchat && \
	: "引用image中でインスコしてあるモジュールを削除" && \
	rm -rf node_modules && \
	: "package.jsonの内容にしたがって--save付きで再インスコする" && \
	npm install --save && \
	#coffee -c /home/hubot/node_modules/hubot-rocketchat/src/*.coffee && \
	cd /home/hubot && \
	node -e "console.log(JSON.stringify('$EXTERNAL_SCRIPTS'.split(',')))" > external-scripts.json && \
	npm install --save $(node -e "console.log('$EXTERNAL_SCRIPTS'.split(',').join(' '))")

CMD bin/hubot -n $BOT_NAME -a rocketchat
