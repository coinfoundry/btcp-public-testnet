FROM debian:stretch
MAINTAINER oliver@weichhold.com

RUN apt-get -y update && apt-get -y install git \
      build-essential pkg-config libc6-dev m4 g++-multilib \
      autoconf libtool ncurses-dev unzip git python \
      zlib1g-dev wget bsdmainutils automake

RUN cd /tmp && git clone https://github.com/BTCPrivate/BitcoinPrivate && \
    cd BitcoinPrivate && ./btcputil/build.sh && mv /tmp/BitcoinPrivate/src/btcpd /usr/bin && mv /tmp/BitcoinPrivate/src/btcp-cli /usr/bin && \
    rm -rf /tmp/*

RUN mkdir /data && chmod 777 /data && touch /data/btcprivate.conf

EXPOSE 8232 8233
WORKDIR /tmp
ENTRYPOINT bgoldd -server -testnet -datadir=/data -rpcuser=user -rpcpassword=pass -rpcport=7932 -rpcbind=0.0.0.0 -rpcallowip=::/0
