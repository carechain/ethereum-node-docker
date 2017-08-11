FROM ethereum/client-go:v1.6.7

ENV NODE_TYPE=boot

ADD start.sh /
ADD config.toml /
RUN chmod a+rx /start.sh

VOLUME /config

ENTRYPOINT /start.sh $NODE_TYPE
