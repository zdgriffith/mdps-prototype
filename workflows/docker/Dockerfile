FROM rockylinux/rockylinux:9
RUN dnf install -y -q -q epel-release && \
  dnf install -y -q \
      python3 \
      tini \
    && \
  dnf clean all -y 

# Create and configured the Python environment
RUN python3 -m venv /opt/asips && \ 
  /opt/asips/bin/python3 -m pip install requests
ENV VIRTUALENV=/opt/asips
ENV PATH=$VIRTUALENV/bin:$PATH

# Install the CCSDS tool
WORKDIR /tmp
RUN curl -LO https://github.com/bmflynn/ccsds-rs/releases/download/0.1.0-beta.11/ccsds-cli_0.1.0-beta.11.tar.gz && \
  tar -xzf ccsds-cli_0.1.0-beta.11.tar.gz && \
  mv x86_64-unknown-linux-gnu/ccsds /opt/asips/bin && \
  ccsds -V

COPY download search /usr/local/bin/ 

ENTRYPOINT ["/usr/bin/tini", "--"]
CMD ["bash"]
