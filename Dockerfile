# Download and install Matlab Compiler Runtime v9.3 (2017b)
#
# This docker file will configure an environment into which the Matlab compiler
# runtime will be installed and in which stand-alone matlab routines (such as
# those created with Matlab's deploytool) can be executed.
#
# See http://www.mathworks.com/products/compiler/mcr/ for more info.

FROM debian:buster-slim

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get -q update && \
    apt-get install -q -y --no-install-recommends \
	  xorg \
      unzip \
      wget \
      curl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
    
# Install the MCR dependencies and some things we'll need and download the MCR
# from Mathworks -silently install it
RUN mkdir /mcr-install && \
    mkdir /opt/mcr && \
    cd /mcr-install && \
    wget -q https://ssd.mathworks.com/supportfiles/downloads/R2021a/Release/1/deployment_files/installer/complete/glnxa64/MATLAB_Runtime_R2021a_Update_1_glnxa64.zip && \
    unzip -q MATLAB_Runtime_R2021a_Update_1_glnxa64.zip && \
    rm -f MATLAB_Runtime_R2021a_Update_1_glnxa64.zip && \
    ./install -destinationFolder /opt/mcr -agreeToLicense yes -mode silent && \
    cd / && \
    rm -rf mcr-install

# Configure environment variables for MCR
ENV LD_LIBRARY_PATH /opt/mcr/v93/runtime/glnxa64:/opt/mcr/v93/bin/glnxa64:/opt/mcr/v93/sys/os/glnxa64
ENV XAPPLRESDIR /opt/mcr/v93/X11/app-defaults
