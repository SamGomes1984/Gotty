FROM ubuntu:20.04
LABEL maintainer="wingnut0310 <wingnut0310@gmail.com>"

# Set the locale
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV GOTTY_TAG_VER v1.0.1

# Install dependencies and SSH server
RUN apt-get -y update && \
    apt-get install -y curl openssh-server && \
    curl -sLk https://github.com/yudai/gotty/releases/download/${GOTTY_TAG_VER}/gotty_linux_amd64.tar.gz \
    | tar xzC /usr/local/bin && \
    apt-get purge --auto-remove -y curl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists*

# Create necessary directories and set up SSH server
RUN mkdir /var/run/sshd

# Set the root password (you can change this to another user if needed)
RUN echo 'root:rootpassword' | chpasswd

# Expose SSH port and GoTTY port
EXPOSE 22 8080

# Copy the GoTTY startup script
COPY /run_gotty.sh /run_gotty.sh

# Make sure the script is executable
RUN chmod 744 /run_gotty.sh

# Run both SSH and GoTTY when the container starts
CMD service ssh start && /bin/bash /run_gotty.sh
