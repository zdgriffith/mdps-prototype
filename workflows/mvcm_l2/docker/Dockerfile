ARG basever=latest
FROM gitlab.ssec.wisc.edu:5555/sips/mdps-images/base:${basever}
COPY deliveries/mvcm/ /software/mvcm/
COPY deliveries/oisst2bin /software/oisst2bin 
COPY docker/run.py /software/run.py

ENV PIP_INDEX_URL=http://devpi.sips/sips/prod/+simple
ENV PIP_TRUSTED_HOST=devpi.sips

COPY docker/requirements.txt /software/
RUN python3 -m pip install -r /software/requirements.txt

# FIXME: We're ignore the leapsec.dat expirations, so make sure it's up to date
ENV GRAIN_DISABLE_DOWNLOAD=1 
ENV GRAIN_IGNORE_EXPIRED=1
