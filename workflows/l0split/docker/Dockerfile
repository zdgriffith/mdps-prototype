FROM gitlab.ssec.wisc.edu:5555/sips/mdps-images/base
RUN python3 -m pip install pystac ccsds
COPY ./workflows/scripts/level0split /usr/local/bin/
