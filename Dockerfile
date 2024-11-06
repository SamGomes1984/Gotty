FROM ubuntu:20.04

LABEL maintainer="wingnut0310 <wingnut0310@gmail.com>"

# Set non-interactive mode for apt-get
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies and clone ttyd repo
RUN apt-get update && \
    apt-get install -y \
    cmake \
    g++ \
    pkg-config \
    libssl-dev \
    libjson-c-dev \
    git \
    make \
    build-essential && \
    git clone https://github.com/tsl0922/ttyd.git && \
    cd ttyd && \
    cmake . && \
    make && \
    make install && \
    apt-get clean

# Copy the run script
COPY run_gotty.sh /run_gotty.sh
RUN chmod +x /run_gotty.sh

# Expose required ports
EXPOSE 8080 22

# Start ssh and ttyd service
CMD ["/bin/bash", "/run_gotty.sh"]
