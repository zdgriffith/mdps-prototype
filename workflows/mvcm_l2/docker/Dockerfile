ARG basetag=latest
FROM gitlab.ssec.wisc.edu:5555/sips/mdps-images/base:${basetag}

# MVCM does not include all of it's required deps in the dist
RUN dnf install -yq \
  compat-libgfortran-48 \
  libjpeg-turbo && \
  dnf clean -yq all

# Deliveries and support software necessary to run pipeline
COPY software/mvcm/ /software/mvcm/
COPY software/oisst2bin/ /software/oisst2bin/
COPY software/l1bscale/ /software/l1bscale/
COPY software/demlw-static/ /software/demlw-static/
COPY docker/run.py /software/run.py

# Python package requirements for iff2, viirsmend, demlw
COPY docker/requirements.txt /software/
RUN python3 -m pip install -r /software/requirements.txt

# FIXME: We're ignore the leapsec.dat expirations, so make sure it's up to date
ENV GRAIN_DISABLE_DOWNLOAD=1 
ENV GRAIN_IGNORE_EXPIRED=1
