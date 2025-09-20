FROM ubuntu

RUN apt-get update \
  && apt install -y python3 python3-pip python3-venv

COPY . .

USER root
