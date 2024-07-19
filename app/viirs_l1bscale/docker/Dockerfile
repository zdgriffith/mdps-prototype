FROM rockylinux/rockylinux:9

ARG version

RUN dnf -y -q install epel-release && \
  dnf -y -q install \
      netcdf \
      netcdf-fortran \
      rsync \
    && \
  dnf -y -q clean all 

COPY ${version}/ /opt/viirs_l1bscale/

ENV LD_LIBRARY_PATH=/opt/viirs_l1bscale/dist/lib
ENV PATH=$PATH:/opt/viirs_l1bscale/dist/bin

RUN useradd app
USER app
