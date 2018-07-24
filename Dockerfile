FROM phusion/baseimage:0.9.19

RUN \
    apt-get update && \
    apt-get install -y \
			nginx \
			fcgiwrap \
			awscli \
			wget \
			xz-utils \
		&& \
    apt-get clean


RUN \
	mkdir -p /usr/local/src/router

ADD ./ /usr/local/src/router/

RUN \
	cd /usr/local/src/router/resources/ && \
	tar -xf gettext-0.19.8.1.tar.xz && \
	cd gettext-0.19.8.1 && \
	./configure && \
	make && \
	make install 

RUN \
	mv /usr/local/src/router/nginx.conf /etc/nginx/nginx.conf && \
	chmod +x /usr/local/src/router/scripts/createPeers.sh && \
	chmod +x /usr/local/src/router/scripts/renginx.sh \
	&& \
	./usr/local/src/router/scripts/createPeers.sh && \
	./usr/local/src/router/scripts/renginx.sh