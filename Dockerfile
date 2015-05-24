FROM debian:jessie
MAINTAINER Volkan Oransoy "volkan.oransoy@bulutfon.com"

RUN apt-get update && apt-get -y --quiet --force-yes upgrade

RUN apt-get install -y --quiet --force-yes locales curl wget autoconf automake devscripts gawk g++ git-core 'libjpeg-dev|libjpeg62-turbo-dev' libncurses5-dev 'libtool-bin|libtool' make python-dev gawk pkg-config libtiff5-dev libperl-dev libgdbm-dev libdb-dev gettext libssl-dev libcurl4-openssl-dev libpcre3-dev libspeex-dev libspeexdsp-dev libsqlite3-dev libedit-dev libldns-dev libpq-dev

WORKDIR /usr/src

RUN git clone https://freeswitch.org/stash/scm/fs/freeswitch.git

WORKDIR /usr/src/freeswitch

RUN /usr/src/freeswitch/bootstrap.sh -j && ./configure --enable-core-pgsql-support && make && make install

CMD /usr/local/freeswitch/bin/freeswitch -ncwait && tail -f /usr/local/freeswitch/log/freeswitch.log
