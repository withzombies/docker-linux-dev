FROM ubuntu:latest

# enable source repos
RUN sed -i '/deb-src/s/^# //' /etc/apt/sources.list && apt update

# update
RUN apt-get update

# Set the locale
RUN apt-get install -y locales locales-all
ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8

ENV DEBIAN_FRONTEND=noninteractive

# Install some essentials
RUN apt-get install -y \
            ubuntu-server \
            vim \
            python \
            python-dev \
            python-pip \
            python-virtualenv \
            python3 \
            python3-pip \
            ruby \
            ruby-dev \
            gem \
            git \
            cmake \
            build-essential \
            sudo

# Cheat by installing the python and ruby build dependencies
RUN apt-get build-dep -y python ruby

# create 'user' user
RUN groupadd -g 1000 user
RUN useradd -rm -d /home/user -s /bin/bash -g user -G sudo -u 1000 user

# Enable passwordless sudo for users under the "sudo" group
RUN sed -i.bkp -e \
      's/%sudo\s\+ALL=(ALL\(:ALL\)\?)\s\+ALL/%sudo ALL=NOPASSWD:ALL/g' \
      /etc/sudoers

# Some ruby deps
RUN gem install bundler

# python deps
RUN su - user -c "pip install --user virtualenv requests flask"
RUN su - user -c "pip3 install --user black"

USER user
WORKDIR /home/user/work

# copy in the rc files
COPY --chown=user:user rc/ /home/user/

