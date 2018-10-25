#!/bin/sh

apt-get update && apt-get install -q -y apt-utils

apt-get update && apt-get install -q -y \
  build-essential \
  cmake \
  imagemagick \
  libboost-all-dev \
  libgazebo7-dev \
  libjansson-dev \
  libtinyxml-dev \
  mercurial \
  nodejs \
  nodejs-legacy \
  npm \
  pkg-config \
  psmisc \
  xvfb

rm -rf /var/lib/apt/lists/*

apt-get update

rm -rf /var/lib/apt/lists/*
