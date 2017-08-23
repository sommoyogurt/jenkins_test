# use a python base image
FROM python:2.7

RUN mkdir -p /var/deus
RUN mkdir -p /var/deus/src
RUN mkdir -p /var/deus/scripts

WORKDIR /var/deus/src

COPY requirements.txt ./
#RUN pip install --no-cache-dir -r requirements.txt
RUN pip install -r requirements.txt

RUN echo "ENVIROMENT: $ENVIROMENT"

ENV PYTHONPATH /var/deus/src

ENV DEUS_HOME /var/deus
