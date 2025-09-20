FROM ubuntu

RUN apt-get update \
  && apt-get install python3 python3-pip python3-venv

COPY . .

USER root
