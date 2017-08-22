# use a node base image
FROM python:2.7

RUN apt-get install -y gcc

WORKDIR /var/deus/src

COPY requirements.txt ./
#RUN pip install --no-cache-dir -r requirements.txt
RUN pip install -r requirements.txt

ENV PYTHONPATH /var/deus/src

ENV DEUS_HOME /var/deus
