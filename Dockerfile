from ubuntu:18.04

ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8

RUN apt-get --yes -o Acquire::GzipIndexes=false update && apt-get --yes upgrade
RUN apt-get install --yes apt-utils apt-transport-https ca-certificates curl gnupg-agent software-properties-common

RUN add-apt-repository --yes --update main
RUN add-apt-repository --yes --update universe
RUN apt-get --yes update

## ANSIBLE
RUN apt-add-repository --yes --update ppa:ansible/ansible
RUN apt-get -y update
RUN apt-get -y install ansible python3-pip python-pip

## DOCKER
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
RUN add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
RUN apt-get -y update
RUN apt-get -y install docker-ce docker-ce-cli containerd.io

## ENV
ENV ANSIBLE_STDOUT_CALLBACK=debug
ENV ANSIBLE_ROLES_PATH=/usr/share/ansible/roles
ENV ANSIBLE_PIPELINING=True

RUN mkdir -p $ANSIBLE_ROLES_PATH

# molecule
RUN pip3 install -U ansible-lint molecule docker

# clean
RUN apt-get --yes autoremove
RUN apt-get --yes autoclean