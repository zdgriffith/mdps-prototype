FROM python:3.12 AS build
ARG version
RUN apt update && apt install -y \
    libhdf4-0-alt \
    libhdf4-alt-dev \ 
  && \
  rm -rf /var/lib/apt/lists/*
RUN python3 -m venv /opt/iff
ENV PATH=$PATH:/opt/iff/bin
ENV VIRTUALENV=/opt/iff
RUN python3 -m pip install -i http://devpi.sips/sips/prod/+simple --trusted-host=devpi.sips "iff2==${version}"

RUN useradd app
USER app

