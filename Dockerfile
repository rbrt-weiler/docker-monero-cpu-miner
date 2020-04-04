FROM debian:stable-slim

LABEL description="Auto-updating Monero CPU miner. Uses the vanilla Monero application."
LABEL version="1.0.0"
LABEL maintainer="Robert Weiler"
LABEL homepage="https://gitlab.com/rbrt-weiler/docker-monero-miner"

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y wget bzip2 && \
    apt-get autoremove -y && \
    apt-get clean -y && \
    rm -rf /var/lib/apt/lists/*

COPY deploy_monero.sh start_mining.sh init.sh /
RUN chmod 0755 /*.sh

RUN useradd -c "Monero Miner" -d /monero -m monero
USER monero
WORKDIR /monero

ENTRYPOINT [ "/init.sh" ]

# vim: set sts=4 et tw=0 :
