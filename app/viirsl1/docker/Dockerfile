FROM rockylinux/rockylinux:9

RUN dnf -y -q install epel-release && \
  dnf -y -q install \
      python3 \
      tini \
    && \
  dnf -y -q clean all

COPY v3.1.0/ /opt/viirsl1/v3.1.0/
COPY docker/entrypoint.sh /
COPY docker/viirsl1 /opt/viirsl1/bin/

ENV PATH=$PATH:/opt/viirsl1/bin

WORKDIR /tmp
RUN useradd app
USER app

ENTRYPOINT ["tini", "--"]
