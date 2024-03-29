FROM debian:stretch-slim

ENV container docker

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update \
    && apt-get install -y --no-install-recommends sudo systemd python python-pip \
        python-setuptools \
    && rm -rf /var/lib/apt/lists/* \
    && rm -Rf /usr/share/doc && rm -Rf /usr/share/man \
    && apt-get clean

RUN pip install --upgrade "pip<21.0"

VOLUME ["/sys/fs/cgroup"]

CMD ["/lib/systemd/systemd"]
