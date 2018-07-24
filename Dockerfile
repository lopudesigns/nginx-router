FROM phusion/baseimage:0.9.19

RUN \
    apt-get update && \
    apt-get install -y \
			nginx \
			fcgiwrap \
			awscli \
			wget \
			xz-utils \
			autoconf \
			automake \
			autotools-dev \
			bsdmainutils \
			build-essential \
			cmake \
			doxygen \
			libboost-all-dev \
			libreadline-dev \
			libssl-dev \
			libtool \
			liblz4-tool \
			ncurses-dev \
			pkg-config \
			gdb \
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