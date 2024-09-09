FROM gitlab.ssec.wisc.edu:5555/sips/mdps-prototype/base

RUN python3 -m pip install pystac 

COPY scripts/level0split /usr/local/bin/
RUN curl https://github.com/bmflynn/ccsds-rs/commits/0.1.0-beta.11
RUN curl -sSfL -O https://github.com/bmflynn/ccsds-rs/releases/download/0.1.0-beta.11/ccsds-cli_0.1.0-beta.11.tar.gz && \
  tar -xzvf ccsds-cli_0.1.0-beta.11.tar.gz && \
  mv -v x86_64-unknown-linux-gnu/ccsds /usr/local/bin/
