FROM rocketchat/hubot-rocketchat:latest
MAINTAINER himmel17
LABEL title="hubot-rocketchat"
LABEL version="0.2"
LABEL description="社内proxy越しにnpmがうまくいかないのでDockerHubでカスタムイメージ作成．hubot-rss-readerを追加．"

ENV EXTERNAL_SCRIPTS=hubot-diagnostics,hubot-help,hubot-google-images,hubot-google-translate,hubot-pugme,hubot-maps,hubot-rules,hubot-shipit,hubot-seen,hubot-links,hubot-mongodb-brain,hubot-rss-reader

# # ENV BOT_NAME "rocketbot"
# ENV BOT_NAME "bot"
# ENV BOT_OWNER "No owner specified"
# ENV BOT_DESC "Hubot with rocketbot adapter"

ENV BOT_NAME="bot"
ENV BOT_OWNER="No owner specified"
ENV BOT_DESC="Hubot with rocketbot adapter"

ENV ROCKETCHAT_URL=43.30.154.37:3000
ENV ROCKETCHAT_ROOM="general"
ENV ROCKETCHAT_USER="bot"
ENV ROCKETCHAT_PASSWORD="botpassword"

USER hubot
WORKDIR /home/hubot

# RUN cd /home/hubot/node_modules/hubot-rocketchat && \
# 	: "引用image中でインスコしてあるモジュールを削除" && \
# 	rm -rf node_modules && \
# 	: "package.jsonの内容にしたがって--save付きで再インスコする" && \
# 	npm install --save && \
# 	#coffee -c /home/hubot/node_modules/hubot-rocketchat/src/*.coffee && \
# 	cd /home/hubot && \
# 	node -e "console.log(JSON.stringify('$EXTERNAL_SCRIPTS'.split(',')))" > external-scripts.json && \
# 	npm install --save $(node -e "console.log('$EXTERNAL_SCRIPTS'.split(',').join(' '))")

# CMD bin/hubot -n $BOT_NAME -a rocketchat

RUN cd /home/hubot/node_modules/hubot-rocketchat && \
    npm rm && \
    cd /home/hubot && \
	npm rm hubot-scripts

## proxy-agent
# RUN npm install --save hubot-scripts && \
# 	npm install --save proxy-agent && \
# 	cd /home/hubot/node_modules/hubot-rocketchat && \
# 	npm install --save && \
# 	cd /home/hubot

# COPY proxy.coffee /home/hubot/scripts/
# COPY proxy.coffee /home/hubot/node_modules/hubot-rocketchat/scripts/

## global-tunnel-ng
RUN npm install --save hubot-scripts && \
	npm install --save global-tunnel-ng && \
	cd /home/hubot/node_modules/hubot-rocketchat && \
	npm install --save && \
	cd /home/hubot

RUN node -e "console.log(JSON.stringify('$EXTERNAL_SCRIPTS'.split(',')))" > external-scripts.json && \
	npm install --save $(node -e "console.log('$EXTERNAL_SCRIPTS'.split(',').join(' '))")

COPY proxy.js /home/hubot/
# RUN node proxy.js

CMD bin/hubot -n $BOT_NAME -a rocketchat
