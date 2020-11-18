from ubuntu:20.04

ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get --yes -o Acquire::GzipIndexes=false update && apt-get --yes upgrade
RUN apt-get install --yes apt-utils apt-transport-https ca-certificates curl gnupg-agent software-properties-common
RUN apt-get install --yes iproute2 net-tools traceroute iputils-ping

RUN add-apt-repository --yes --update main
RUN add-apt-repository --yes --update universe
RUN apt-get --yes update

## ANSIBLE
#RUN apt-add-repository --yes --update ppa:ansible/ansible
#RUN apt-get -y update
RUN apt-get -y install build-essential libssl-dev libffi-dev python3 python3-pip python3-dev # ansible
# switch to python3 by default
RUN update-alternatives --install /usr/bin/python python /usr/bin/python3 1
RUN update-alternatives --install /usr/bin/pip pip /usr/bin/pip3 1

## DOCKER
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
RUN add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
RUN apt-get -y update
RUN apt-get -y install docker-ce docker-ce-cli containerd.io

## ENV
ENV ANSIBLE_STDOUT_CALLBACK=debug
ENV ANSIBLE_CALLBACK_WHITELIST=profile_tasks
ENV ANSIBLE_NOCOWS=True

RUN mkdir -p $ANSIBLE_ROLES_PATH

# molecule
RUN pip install -U ansible yamllint ansible-lint molecule molecule-docker

# clean
RUN apt-get --yes autoremove
RUN apt-get --yes autoclean
