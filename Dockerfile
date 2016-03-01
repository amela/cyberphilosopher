# Cybernetic Philosopher

FROM debian:jessie
MAINTAINER ami the white [http://amela.rocks/] <ami@tnode.com>

ENV DEBIAN_FRONTEND noninteractive
WORKDIR /srv/

# packages
RUN apt-get update -qq \
 && apt-get install -y \
    python \
    python-pip \
    python-virtualenv \
    git

RUN apt-get install -y \
    g++ gfortran python-dev libopenblas-dev liblapack-dev \
    python-h5py libyaml-dev graphviz \
    pkg-config libpng-dev libfreetype6-dev

# copy datasets
ADD datasets/ ./datasets

# setup virtualenv
ADD requirements.sh ./
RUN ./requirements.sh

# setup parser
ADD *.py ./

# expose interface
VOLUME /srv

ENTRYPOINT ["/srv/venv/bin/python", "/srv/lstm_text_generation.py"]
CMD []
