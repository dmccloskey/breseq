# Dockerfile to build Breseq container images
# Based on Ubuntu

# Set the base image to Ubuntu
FROM ubuntu:latest

# File Author / Maintainer
MAINTAINER Douglas McCloskey <dmccloskey87@gmail.com>

# Install wget
RUN apt-get update && apt-get install -y wget

# Install cufflinks from http
WORKDIR /usr/local/
RUN wget http://github.com/barricklab/breseq/releases/download/v0.26.0/breseq-0.26.0-Linux-x86_64.tar.gz
RUN tar -zxvf breseq-0.26.0-Linux-x86_64.tar.gz

# add cufflinks to path
ENV PATH /usr/local/breseq-0.26.0-Linux-x86_64/bin:$PATH

# Cleanup
RUN rm -rf breseq-0.26.0-Linux-x86_64.tar.gz
RUN apt-get clean

# Create an app user
ENV HOME /home/user
RUN useradd --create-home --home-dir $HOME user \
    && chmod -R u+rwx $HOME \
    && chown -R user:user $HOME

WORKDIR $HOME
USER user
