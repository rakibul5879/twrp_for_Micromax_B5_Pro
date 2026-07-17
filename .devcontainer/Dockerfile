FROM ubuntu:20.04

# Point apt to old-releases to ensure package installations work
RUN sed -i 's/://ubuntu.com' /etc/apt/sources.list && \
    sed -i 's/://ubuntu.com' /etc/apt/sources.list

# Install basic development utilities
RUN apt-get update && apt-get install -y \
    curl \
    git \
    sudo \
    gh \
    python2 \
    openjdk-8\
    docker \
    && rm -rf /var/lib/apt/lists/*
