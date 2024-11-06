# Start with an Ubuntu base image
FROM ubuntu:20.04

# Set environment variables
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en

# Install necessary packages
RUN apt-get update && \
    apt-get install -y \
    curl \
    openssh-server \
    sudo \
    bash \
    && rm -rf /var/lib/apt/lists/*

# Create a user for SSH access (you can customize this)
RUN useradd -m -s /bin/bash ubuntu && \
    echo "ubuntu:ubuntu" | chpasswd && \
    adduser ubuntu sudo

# Set up the SSH service
RUN mkdir /var/run/sshd
EXPOSE 22

# Install a web terminal (example: ttyd)
RUN apt-get install -y cmake g++ pkg-config libssl-dev libjson-c-dev \
    && git clone https://github.com/tsl0922/ttyd.git \
    && cd ttyd && cmake . && make && make install \
    && apt-get clean

# Expose ttyd port for web terminal
EXPOSE 7681

# Start SSH and ttyd
CMD service ssh start && ttyd bash
