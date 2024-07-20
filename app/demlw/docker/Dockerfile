FROM python:3.12 AS build
RUN apt update && apt install -y \
    libhdf4-0-alt \
    libhdf4-alt-dev \ 
  && \
  rm -rf /var/lib/apt/lists/*
RUN python3 -m venv /opt/demlw
ENV PATH=$PATH:/opt/demlw/bin
ENV VIRTUALENV=/opt/demlw
COPY ./demlw/ /tmp/code
RUN python3 -m pip install -i http://devpi.sips/sips/prod/+simple --trusted-host=devpi.sips /tmp/code

RUN useradd app
USER app

