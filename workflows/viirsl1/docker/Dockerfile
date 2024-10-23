FROM gitlab.ssec.wisc.edu:5555/sips/viirs_l1-build/viirsl1:v3.2.3

USER root
RUN dnf install -y python3.12-pip

COPY docker/requirements.txt /tmp/
RUN $APPDIR/bin/python3 -m pip install -r /tmp/requirements.txt
COPY scripts/catgen /usr/local/bin/
COPY workflows/viirsl1/scripts/level1a /usr/local/bin/

