FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV PATH="/usr/games:${PATH}"

RUN apt-get update && apt-get install -y \
    fortune-mod \
    cowsay \
    netcat-openbsd \
    dos2unix \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY wisecow.sh .

RUN dos2unix wisecow.sh && chmod +x wisecow.sh

EXPOSE 4499

CMD ["bash", "./wisecow.sh"]
