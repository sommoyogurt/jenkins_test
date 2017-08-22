# use a node base image
FROM python:2.7

WORKDIR /var/deus/src

COPY requirements.txt ./
#RUN pip install --no-cache-dir -r requirements.txt
RUN pip install -r requirements.txt
