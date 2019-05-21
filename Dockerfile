from ubuntu:latest

RUN apt-get -y -o Acquire::GzipIndexes=false update

RUN apt-get -y install apt-transport-https ca-certificates curl gnupg-agent software-properties-common

RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -

RUN add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

RUN apt-get -y update

RUN apt-get -y install docker-ce docker-ce-cli containerd.io

RUN apt-get -y install python-pip

RUN pip install virtualenv ansible molecule docker

ENV ANSIBLE_LOAD_CALLBACK_PLUGINS=1

ENV ANSIBLE_STDOUT_CALLBACK=debug

ENV ANSIBLE_CALLABLE_WHITELIST="debug:profile_tasks:profile_roles"

ENV PROFILE_TASKS_TASK_OUTPUT_LIMIT=1000

ENV ANSIBLE_ROLES_PATH=/var/lib/ansible/roles

RUN mkdir -p $ANSIBLE_ROLES_PATH

COPY requirements.yml $ANSIBLE_ROLES_PATH/

RUN ansible-galaxy install -r $ANSIBLE_ROLES_PATH/requirements.yml