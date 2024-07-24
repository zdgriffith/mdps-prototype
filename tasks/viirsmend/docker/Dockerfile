FROM python:3.12 AS build
RUN apt update && apt install -y \
    libhdf4-0 \
    libhdf4-dev \ 
  && \
  rm -rf /var/lib/apt/lists/*
RUN python3 -m venv /opt/viirsmend
ENV PATH=$PATH:/opt/viirsmend/bin
ENV VIRTUALENV=/opt/viirsmend
COPY ./viirsmend/ /tmp/code
RUN python3 -m pip install "numpy<2" && \
  python3 -m pip install -i http://devpi.sips/sips/prod/+simple --trusted-host=devpi.sips /tmp/code

RUN useradd app
USER app

